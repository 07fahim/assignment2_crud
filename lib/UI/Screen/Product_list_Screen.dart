import 'dart:convert';
import 'package:assignment2_crud/UI/Screen/Product_Create_Screen.dart';
import 'package:assignment2_crud/UI/Style/style.dart';
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
      "assets/images/SVG_Background1.svg",
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
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.network(
                            productList[index].image ?? 'Unknown',
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported, size: 60),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productList[index].productName ?? 'Unknown',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,fontWeight: FontWeight.w700
                                  )
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Product Code: ${productList[index].productCode ?? 'Unknown'}',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Quantity: ${productList[index].quantity ?? 'Unknown'}',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Price: ${productList[index].unitPrice ?? 'Unknown'}',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Total Price: ${productList[index].totalPrice ?? 'Unknown'}',
                                  style: const TextStyle(
                                      color: Colors.lime,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration:  BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color:Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.edit, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
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
        onPressed: () {
          Navigator.pushNamed(context, ProductCreateScreen.name);
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
