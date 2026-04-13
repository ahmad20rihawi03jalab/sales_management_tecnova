import 'package:flutter/material.dart';

class StockItem extends StatelessWidget {
  final String name;
  final int quantity;
  final String unity;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  StockItem({
    required this.name,
    required this.quantity,
    required this.unity,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xff1e2837),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit, size: 18),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, size: 18),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          Text(name, style: TextStyle(fontSize: 22)),
          SizedBox(height: 10),
          Text(
            '$unity $quantity',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
