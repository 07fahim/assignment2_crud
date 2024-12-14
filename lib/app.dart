
import 'package:assignment2_crud/UI/Screen/Product_list_Screen.dart';
import 'package:assignment2_crud/UI/Screen/Update_Product_Screen.dart';
import 'package:flutter/material.dart';

import 'UI/Screen/Product_Create_Screen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context) => const ProductListScreen(),
        ProductCreateScreen.name:(context) =>const ProductCreateScreen(),
        ProductUpdateScreen.name:(context) =>const ProductUpdateScreen()
      },
    );
  }
}
