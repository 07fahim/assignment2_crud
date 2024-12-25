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
  const ProductListScreen({super.key, required bool isDarkMode, required void Function() onThemeToggle});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _getProductListInProgress = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Widget ScreenBackground(BuildContext context) {
    return _isDarkMode
        ? Container(
      color: darkBackgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    )
        : SvgPicture.asset(
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
      backgroundColor: _isDarkMode ? darkBackgroundColor : Colors.white,
      appBar: AppBar(
        backgroundColor: _isDarkMode ? darkCardColor : colorWhite,
        title: Text(
          "CRUD APP",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: _isDarkMode ? darkTextColor : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? darkIconColor : Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          RefreshIndicator(
            onRefresh: () async {
              await _getProductList();
            },
            child: Visibility(
              visible: !_getProductListInProgress,
              replacement: Center(
                child: CircularProgressIndicator(
                  color: _isDarkMode ? darkTextColor : colorDarkBlue,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productList[index],
                    onRefresh: _getProductList,
                    isDarkMode: _isDarkMode,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _isDarkMode ? darkCardColor : Colors.grey.shade300,
        elevation: 20,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 11,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: _isDarkMode ? darkCardColor : colorWhite,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 10,
            ),
          ),
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              ProductCreateScreen.name,
            );
            if (result == true) {
              _getProductList();
            }
          },
          child: Image.asset(
            "assets/images/shopping-cart.png",
            fit: BoxFit.contain,
            width: 40,
          ),
        ),
      ),
    );
  }

  Future<void> _getProductList() async {
    try {
      setState(() {
        productList.clear();
        _getProductListInProgress = true;
      });

      Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
      Response response = await get(uri);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'success') {
          for (Map<String, dynamic> p in decodedData['data']) {
            Product product = Product(
              id: p['_id'],
              productName: p['ProductName'],
              productCode: p['ProductCode'],
              image: p['Img'],
              unitPrice: p['UnitPrice'],
              quantity: p['Qty'],
              totalPrice: p['TotalPrice'],
              createdDate: p['CreatedDate'],
            );
            productList.add(product);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _getProductListInProgress = false;
        });
      }
    }
  }
}