import 'dart:convert';

import 'package:assignment2_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../Style/style.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _customQtyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  String? selectedQuantity;
  List<String> quantityItems = [
    "1 piece",
    "2 piece",
    "3 piece",
    "4 piece",
    "5 piece",
    "custom"
  ];

  @override
  void initState() {
    super.initState();
    _initializeProductData();
  }

  void _initializeProductData() {
    _nameTEController.text = widget.product.productName ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';

    // Handle quantity initialization
    if (widget.product.quantity != null) {
      String quantityWithPiece = "${widget.product.quantity} piece";
      // Check if the quantity is not in the predefined list
      if (!quantityItems.contains(quantityWithPiece)) {
        // Add it to the quantityItems list
        quantityItems.add(quantityWithPiece);
      }
      selectedQuantity = quantityWithPiece;
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: colorDarkBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCustomQuantityDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Enter Custom Quantity',
            style: GoogleFonts.roboto(fontSize: 20),
          ),
          content: TextField(
            controller: _customQtyController,
            keyboardType: TextInputType.number,
            decoration: AddInputDecoration("Enter quantity"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedQuantity = null;
                });
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_customQtyController.text.isNotEmpty) {
                  final quantity = int.tryParse(_customQtyController.text);
                  if (quantity != null && quantity > 0) {
                    setState(() {
                      String newQuantity = "${_customQtyController.text} piece";
                      if (!quantityItems.contains(newQuantity)) {
                        quantityItems.add(newQuantity);
                      }
                      selectedQuantity = newQuantity;
                      _customQtyController.clear();
                    });
                    Navigator.pop(context);
                  } else {
                    _showMessage('Please enter a valid quantity');
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
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

  Widget _buildQuantityDropdown() {
    return AppDropDownStyle(
      DropdownButton<String>(
        style: GoogleFonts.merriweather(color: colorGrey, fontSize: 20),
        dropdownColor: colorWhite,
        value: selectedQuantity,
        hint: Text(
            "Select QT",
            style: GoogleFonts.merriweather(color: colorGrey, fontSize: 20)
        ),
        items: quantityItems.map((String qty) {
          return DropdownMenuItem(
            value: qty,
            child: Text(qty),
          );
        }).toList(),
        onChanged: _updateProductInProgress ? null : (value) {
          setState(() {
            if (value == "custom") {
              _showCustomQuantityDialog();
            } else {
              selectedQuantity = value;
            }
          });
        },
        isExpanded: true,
        underline: Container(),
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
              if (double.tryParse(value!) == null) {
                return "Please enter a valid number";
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
              if (double.tryParse(value!) == null) {
                return "Please enter a valid number";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuantityDropdown(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: !_updateProductInProgress,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                style: AppButtonStyle(),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  if (selectedQuantity == null) {
                    _showMessage('Please select quantity');
                    return;
                  }
                  _updateProduct();
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

    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');
    Map<String, dynamic> requestBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": selectedQuantity?.replaceAll(' piece', ''),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody)
    );

    _updateProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been updated!'),
        ),
      );

      Navigator.pop(context, true);
    } else {
      if (!mounted) return;
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
    _imageTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _customQtyController.dispose();
    super.dispose();
  }
}