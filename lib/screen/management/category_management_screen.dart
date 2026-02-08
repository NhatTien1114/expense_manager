import 'package:expense_manager/model/Category.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatgegoryManagementScreen extends StatelessWidget {
  const CatgegoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories"),
        backgroundColor: Colors.deepPurple, // Themed color similar to your inspirations
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              var category = provider.categories[index];
              return ListTile(
                title: Text(category.name),
                trailing: Icon(Icons.delete),
                onTap: () => provider.deleteCategory(category.id),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddCategoryDialog(context),
          child: Icon(Icons.add),
          tooltip: "Add Category",
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Category"),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Category Name"),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    final newCategory = Category(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _controller.text
                    );
                    Provider.of<ExpenseProvider>(context, listen: false).addCategory(newCategory);
                    _controller.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add")
              )
            ],
          );
        },
    );
  }
}
