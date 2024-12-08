import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

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

  String? selectedQuantity;
  List<String> quantityItems = ["1 piece", "2 piece", "3 piece", "4 piece", "5 piece", "custom"];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        backgroundColor:colorDarkBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCustomQuantityDialog() {
    showDialog(
      context: context,
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
                  setState(() {
                    String newQuantity = "${_customQtyController.text} piece";
                    if (!quantityItems.contains(newQuantity)) {
                      quantityItems.add(newQuantity);
                    }
                    selectedQuantity = newQuantity;
                    _customQtyController.clear();
                  });
                  Navigator.pop(context);
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
        onChanged: (value) {
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
          _buildQuantityDropdown(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: AppButtonStyle(),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                }
                if (selectedQuantity == null) {
                  _showMessage('Please select quantity');
                  return;
                }
                // Add your form submission logic here
                print('Please select quantity');
              },
              child: EleButtonChild("Create Product"),
            ),
          ),
        ],
      ),
    );
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