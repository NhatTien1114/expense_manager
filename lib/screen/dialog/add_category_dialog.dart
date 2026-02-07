import 'package:expense_manager/model/Category.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(Category) onAdd;
  const AddCategoryDialog({required this.onAdd});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new Category"),
      content: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(labelText: "Category Name"),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
        TextButton(
            onPressed: () {
              var newCategory = Category(
                id: DateTime.now().toString(),
                name: _nameController.text
              );
              widget.onAdd(newCategory);
              Provider.of<ExpenseProvider>(context, listen: false).addCategory(newCategory);
              _nameController.clear();
              Navigator.of(context).pop();
            },
            child: Text("Add")
        )
      ],
    );
  }
  @override
  void dispose() {
    _nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
