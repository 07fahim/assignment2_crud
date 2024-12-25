import 'package:assignment2_crud/app.dart';
import 'package:assignment2_crud/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const CrudApp(),
    ),
  );
}
