import 'package:expense_manager/model/Tag.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagManagementScreen extends StatelessWidget {
  const TagManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Tags"),
        backgroundColor: Colors.deepPurple, // Themed color similar to your inspirations
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tags.length,
              itemBuilder: (context, index) {
                var tag = provider.tags[index];
                return ListTile(
                  title: Text(tag.name),
                  trailing: Icon(Icons.delete),
                  onTap: () => provider.deleteTag(tag.id),
                );
              },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTagDialog(context),
          child: Icon(Icons.add),
          tooltip: "Add Tag",
      ),
    );
  }

  void _showAddTagDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Tags"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: "Tag Name"),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  final newTag = Tag(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _controller.text
                  );
                  Provider.of<ExpenseProvider>(context, listen: false).addTag(newTag);
                  _controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Add")
            )
          ],
        );
      }
    );
  }
}
