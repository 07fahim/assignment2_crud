import 'dart:convert';

import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  static const String name = '/update-product';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _quantityController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorDarkBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: Text(
          "Update Product",
          style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: _buildProductForm(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _nameTEController,
            decoration: AddInputDecoration("Product Name"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter product name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _codeTEController,
            decoration: AddInputDecoration("Product Code"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter product code";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _imageTEController,
            decoration: AddInputDecoration("Product Image"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter product image";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _priceTEController,
            keyboardType: TextInputType.number,
            decoration: AddInputDecoration("Unit Price"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter unit price";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _totalPriceTEController,
            keyboardType: TextInputType.number,
            decoration: AddInputDecoration("Total Price"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter total price";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(fontSize: 22),
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: AddInputDecoration("Quantity"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter quantity";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: _updateProductInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                style: AppButtonStyle(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProduct();
                  } else {
                    _showMessage("Please correct the errors in the form.");
                  }
                },
                child: EleButtonChild("Update Product"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> requestBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    Response response = await post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been updated!'),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product update failed! Try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
