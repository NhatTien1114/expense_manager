import 'package:expense_manager/providers/expense_provider.dart';
import 'package:expense_manager/screen/home_screen.dart';
import 'package:expense_manager/screen/management/category_management_screen.dart';
import 'package:expense_manager/screen/management/tag_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage,));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;
  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ExpenseProvider(localStorage))
        ],
      child: MaterialApp(
        title: "Expense Tracker",
        debugShowMaterialGrid: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/manage_categories': (context) => CatgegoryManagementScreen(),
          '/manage_tags': (context) => TagManagementScreen(),
        }
      ),
    );
  }
}