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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        //titleTextStyle: const TextStyle(color:Colors.white,fontSize: 24,fontWeight: FontWeight.w400),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30), child: _buildProductForm()),
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
            style: GoogleFonts.roboto(
              fontSize: 24,
            ),
            controller: _nameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {},
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
            style: GoogleFonts.roboto(
              fontSize: 24,
            ),
            controller: _codeTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {},
            decoration: AddInputDecoration("Product Code"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter product name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: GoogleFonts.roboto(
              fontSize: 24,
            ),
            controller: _imageTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {},
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
            style: GoogleFonts.roboto(
              fontSize: 24,
            ),
            controller: _priceTEController,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {},
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
            style: GoogleFonts.roboto(
              fontSize: 24,
            ),
            controller: _totalPriceTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            onChanged: (value) {},
            decoration: AddInputDecoration("Total Price"),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return "Enter total price";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AppDropDownStyle(DropdownButton(
            style: GoogleFonts.merriweather(color: colorGrey, fontSize: 20),
            dropdownColor: colorWhite,
            value: "",
            items: const [
              DropdownMenuItem(
                value: "",
                child: Text("Select QT"),
              ),
              DropdownMenuItem(
                value: "1 piece",
                child: Text("1 piece"),
              ),
              DropdownMenuItem(
                value: "2 piece",
                child: Text("2 piece"),
              ),
              DropdownMenuItem(
                value: "3 piece",
                child: Text("3 piece"),
              ),
              DropdownMenuItem(
                value: " 4 piece",
                child: Text("4 piece"),
              ),
              DropdownMenuItem(
                value: "5 piece",
                child: Text("5 piece"),
              ),
            ],
            onChanged: (value) {},
            isExpanded: true,
            underline: Container(),
          )),
          const SizedBox(height: 20),
          Container(
            child: ElevatedButton(
                style: AppButtonStyle(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: EleButtonChild("Create Product")),
          ),
        ],
      ),
    );
  }
}
