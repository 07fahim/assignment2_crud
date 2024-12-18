import 'dart:convert';
import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  static const String name = '/create-product';

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _customQtyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createProductInProgress = false;

  String? selectedQuantity;
  List<String> quantityItems = [
    "1 piece",
    "2 piece",
    "3 piece",
    "4 piece",
    "5 piece",
    "custom"
  ];

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
          "Create Product",
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
        onChanged: _createProductInProgress ? null : (value) {
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
              visible: !_createProductInProgress,
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
                  _createNewProduct();
                },
                child: EleButtonChild("Create Product"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createNewProduct() async {
    try {
      _createProductInProgress = true;
      setState(() {});

      Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
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

      if (response.statusCode == 200) {
        _clearTextFields();
        _showMessage('New product added successfully!');
        Navigator.pop(context, true);  // Add this line to return true
      } else {
        _showMessage('Failed to add product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage('Error occurred: ${e.toString()}');
    } finally {
      _createProductInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _priceTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();
    setState(() {
      selectedQuantity = null;
    });
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