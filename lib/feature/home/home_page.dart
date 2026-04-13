import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/item_cupit/item_cupit.dart';
import 'bloc/item_cupit/item_state.dart';
import '../../Data/models/item_model.dart';
import 'widgets/stock_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showItemDialog(BuildContext context, {ItemModel? itemToUpdate}) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // تعريف الـ Controllers
    final TextEditingController nameController = TextEditingController(
      text: itemToUpdate?.name ?? '',
    );
    final TextEditingController quantityController = TextEditingController(
      text: itemToUpdate?.quantity.toString() ?? '',
    );
    final TextEditingController unitController = TextEditingController(
      text: itemToUpdate?.unity ?? '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          itemToUpdate == null ? "إضافة عنصر جديد" : "تعديل العنصر",
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "* اسم العنصر",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? "يجب تعبئة اسم العنصر"
                      : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    labelText: "* الكمية",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? "يجب تعبئة الكمية"
                      : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: unitController,
                  decoration: const InputDecoration(
                    labelText: "* الوحدة (كيلو، قطعة...)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? "يجب تعبئة الوحدة"
                      : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // تنظيف الذاكرة قبل الإغلاق
              nameController.dispose();
              quantityController.dispose();
              unitController.dispose();
              Navigator.pop(dialogContext);
            },
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7373d7),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final item = ItemModel(
                  id: itemToUpdate?.id,
                  name: nameController.text,
                  quantity: double.tryParse(quantityController.text) ?? 0.0,
                  unity: unitController.text,
                );

                if (itemToUpdate == null) {
                  context.read<ItemCubit>().addItem(item);
                } else {
                  context.read<ItemCubit>().updateItem(item);
                }

                // تنظيف الذاكرة بعد النجاح وقبل إغلاق النافذة
                nameController.dispose();
                quantityController.dispose();
                unitController.dispose();
                Navigator.pop(dialogContext);
              }
            },
            child: Text(
              itemToUpdate == null ? "إضافة" : "تعديل",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((_) {
      // احتياطاً: في حال تم إغلاق الـ Dialog بالضغط خارجها (Barrier dismiss)
      // نقوم بالتأكد من تدمير الـ controllers إذا لم يتم تدميرها بالفعل
      nameController.dispose();
      quantityController.dispose();
      unitController.dispose();
    });
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit()..getItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff7373d7),
          title: const Text('Shopping List'),
          centerTitle: true,
        ),
        body: BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {
            if (state is ItemError) {
              _showSnackBar(context, state.message, Colors.red);
            } else if (state is ItemAddSuccess) {
              _showSnackBar(context, "تمت إضافة العنصر بنجاح", Colors.blue);
            } else if (state is ItemUpdateSuccess) {
              _showSnackBar(context, "تم تعديل العنصر بنجاح", Colors.blue);
            } else if (state is ItemDeleteSuccess) {
              _showSnackBar(context, "تم حذف العنصر بنجاح", Colors.orange);
            }
          },
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemGetSuccess) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text("القائمة فارغة، أضف عناصر جديدة"),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return StockItem(
                    name: item.name,
                    quantity: item.quantity.toInt(),
                    unity: item.unity,
                    onDelete: () =>
                        context.read<ItemCubit>().deleteItem(item.id!),
                    onEdit: () => _showItemDialog(context, itemToUpdate: item),
                  );
                },
              );
            }
            return const Center(child: Text("اضغط على + للبدء"));
          },
        ),
        floatingActionButton: Builder(
          builder: (fabContext) => FloatingActionButton(
            onPressed: () => _showItemDialog(fabContext),
            backgroundColor: const Color(0xff7373d7),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
