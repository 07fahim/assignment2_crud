import 'package:assignment2_crud/Widgets/product_item.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD APP"),
        centerTitle: true,
        titleTextStyle:GoogleFonts.poppins(
          fontSize: 22,color: Colors.black,fontWeight: FontWeight.w500
        ),
      ),
      body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context,index){
        return
      }),
    );
  }
}
