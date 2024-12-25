import 'package:assignment2_crud/UI/Screen/Product_Create_Screen.dart';
import 'package:assignment2_crud/UI/Screen/Product_list_Screen.dart';
import 'package:assignment2_crud/UI/Screen/Update_product_Screen.dart';
import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatefulWidget {
  const CrudApp({super.key});

  @override
  State<CrudApp> createState() => _CrudAppState();
}

class _CrudAppState extends State<CrudApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: isDarkMode ? darkBackgroundColor : Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? darkCardColor : colorWhite,
          titleTextStyle: TextStyle(
            color: isDarkMode ? darkTextColor : Colors.black,
          ),
          iconTheme: IconThemeData(
            color: isDarkMode ? darkIconColor : Colors.black,
          ),
        ),
        cardColor: isDarkMode ? darkCardColor : Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: isDarkMode ? darkTextColor : Colors.black,
          ),
          bodyMedium: TextStyle(
            color: isDarkMode ? darkIconColor : Colors.grey,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = ProductListScreen(
            isDarkMode: isDarkMode,
            onThemeToggle: toggleTheme,
          );
        } else if (settings.name == ProductCreateScreen.name) {
          widget = ProductCreateScreen(isDarkMode: isDarkMode);
        } else if (settings.name == UpdateProductScreen.name) {
          final Product product = settings.arguments as Product;
          widget = UpdateProductScreen(
            product: product,
            isDarkMode: isDarkMode,
          );
        }

        return MaterialPageRoute(
          builder: (context) => widget,
        );
      },
    );
  }
}