import 'package:expense_manager/model/Tag.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTagDialog extends StatefulWidget {
  final Function(Tag) onAdd;
  const AddTagDialog({required this.onAdd});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new Tag"),
      content: TextFormField(
        decoration: InputDecoration(labelText: "Tag Name"),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
        TextButton(
            onPressed: () {
              var newTag = Tag(
                id: DateTime.now().toString(),
                name: _nameController.text
              );
              widget.onAdd(newTag);
              Provider.of<ExpenseProvider>(context, listen: false).addTag(newTag);
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
