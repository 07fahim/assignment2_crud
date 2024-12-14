
import 'package:assignment2_crud/UI/Screen/Product_list_Screen.dart';
import 'package:assignment2_crud/UI/Screen/Update_Product_Screen.dart';
import 'package:flutter/material.dart';

import 'UI/Screen/Product_Create_Screen.dart';
import 'models/product.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = const ProductListScreen();
        } else if (settings.name == ProductCreateScreen.name) {
          widget = const ProductCreateScreen();
        } else if (settings.name == ProductUpdateScreen.name) {
          final Product product = settings.arguments as Product;
          widget = ProductUpdateScreen(product: product);
        }

        return MaterialPageRoute(
          builder: (context) => widget,  // Fixed the builder syntax
        );
      },
    );
  }
}
