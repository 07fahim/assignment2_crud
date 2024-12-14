import 'dart:convert';

import 'package:assignment2_crud/Widgets/product_item.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList=[];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }
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
        return ProductItem(product: productList[index]);
      }),
    );
  }
  Future<void> _getProductList()async{
    Uri uri =Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response =await get(uri);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      final decodedData=jsonDecode(response.body);
      print(decodedData['status']);
      for(Map<String,dynamic> p in decodedData['data']){
        Product product=Product(
            id: p['_id'],
            productName: p['ProductName'],
            productCode: p['ProductCode'],
            image: p['Img'],
            unitPrice: p['UnitPrice'],
            quantity: p['Qty'],
            totalPrice: p['TotalPrice'],
            createdDate: p['CreatedDate']
        );
        productList.add(product);
      }
      setState(() {

      });
    }

  }

}

