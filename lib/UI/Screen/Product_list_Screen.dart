import 'dart:convert';
import 'package:assignment2_crud/UI/Screen/Product_Create_Screen.dart';
import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:assignment2_crud/Widgets/product_item.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _getProductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Widget ScreenBackground(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/SVG_Background.svg",
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD APP"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
        actions: [IconButton(onPressed: (){
          _getProductList();
        }, icon: const Icon(Icons.refresh_sharp))],
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          RefreshIndicator(
            onRefresh: () async{
              _getProductList();
            },
            child: Visibility(
              visible: _getProductListInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(product: productList[index], onRefresh:_getProductList);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorBlue,
        shape: const CircleBorder(),
        onPressed: () async {  // Make this async
          final result = await Navigator.pushNamed(context, ProductCreateScreen.name);
          if (result == true) {  // Check if product was created successfully
            _getProductList();  // Refresh the list
          }
        },
        child: const Icon(Icons.add, color: colorDarkBlue),
      ),
    );
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      print(decodedData['status']);
      for (Map<String, dynamic> p in decodedData['data']) {
        Product product = Product(
            id: p['_id'],
            productName: p['ProductName'],
            productCode: p['ProductCode'],
            image: p['Img'],
            unitPrice: p['UnitPrice'],
            quantity: p['Qty'],
            totalPrice: p['TotalPrice'],
            createdDate: p['CreatedDate']);
        productList.add(product);
      }
      setState(() {});
    }
    _getProductListInProgress = false;
    setState(() {});
  }

}