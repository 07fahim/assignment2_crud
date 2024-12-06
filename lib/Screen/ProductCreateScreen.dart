import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Style/style.dart';

class Productcreatescreen extends StatefulWidget {
  const Productcreatescreen({super.key});

  @override
  State<Productcreatescreen> createState() => _ProductcreatescreenState();
}

class _ProductcreatescreenState extends State<Productcreatescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:colorWhite,
        title: Text("Create Product",
            style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.w400)),
        //titleTextStyle: const TextStyle(color:Colors.white,fontSize: 24,fontWeight: FontWeight.w400),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {},
                      decoration: AddInputDecoration("Product Name"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {},
                      decoration: AddInputDecoration("Product Code"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {},
                      decoration: AddInputDecoration("Product Image"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {},
                      decoration: AddInputDecoration("Unit Price"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {},
                      decoration: AddInputDecoration("Total Price"),
                    ),
                    const SizedBox(height: 20),

                    AppDropDownStyle(
                        DropdownButton(style:GoogleFonts.merriweather(
                          color: colorGrey,fontSize: 20

                        ),
                          dropdownColor:colorWhite,
                            value: "",
                            items:
                    const [
                      DropdownMenuItem(child:Text("Select QT") ,value: "",),
                      DropdownMenuItem(child:Text("1 piece") ,value: "1 piece",),
                      DropdownMenuItem(child:Text("2 piece") ,value: "2 piece",),
                      DropdownMenuItem(child:Text("3 piece") ,value: "3 piece",),
                      DropdownMenuItem(child:Text("4 piece") ,value: " 4 piece",),
                      DropdownMenuItem(child:Text("5 piece") ,value: "5 piece",),

                    ]
                        , onChanged: (value){},
                        isExpanded: true,
                          underline:Container(),
                        )),
                    const SizedBox(height: 20),

                    Container(
                      child: ElevatedButton(
                          style: AppButtonStyle(),
                          onPressed: (){}, child:EleButtonChild("Submit")),
                    ),


                  ],
                )),
          )
        ],
      ),
    );
  }
}
