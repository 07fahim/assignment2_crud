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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      // Force rebuild all screens
      if (_navigatorKey.currentState != null) {
        _navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              isDarkMode: isDarkMode,
              onThemeToggle: toggleTheme,
            ),
          ),
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
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

        switch (settings.name) {
          case '/':
            widget = ProductListScreen(
              key: UniqueKey(),
              isDarkMode: isDarkMode,
              onThemeToggle: toggleTheme,
            );
            break;

          case ProductCreateScreen.name:
            widget = ProductCreateScreen(
              key: UniqueKey(),
              isDarkMode: isDarkMode,
              onThemeToggle: toggleTheme,
            );
            break;

          case UpdateProductScreen.name:
            final Product product = settings.arguments as Product;
            widget = UpdateProductScreen(
              key: UniqueKey(),
              product: product,
              isDarkMode: isDarkMode,
              onThemeToggle: toggleTheme,
            );
            break;

          default:
            widget = ProductListScreen(
              key: UniqueKey(),
              isDarkMode: isDarkMode,
              onThemeToggle: toggleTheme,
            );
        }

        return MaterialPageRoute(
          builder: (context) => widget,
        );
      },
    );
  }
}