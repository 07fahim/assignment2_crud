
import 'package:flutter/material.dart';

import 'UI/Screen/Product_Create_Screen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ProductCreateScreen() ,
    );
  }
}
