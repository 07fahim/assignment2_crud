import 'package:flutter/material.dart';

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
        backgroundColor: Colors.greenAccent,
        title: const Text("Create Product"),
        titleTextStyle: const TextStyle(color:Colors.white,fontSize: 24,fontWeight: FontWeight.w400),
      ),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(onChanged: (value){},),
                  TextFormField(onChanged: (value){},),
                  TextFormField(onChanged: (value){},),
                  TextFormField(onChanged: (value){},),
                  TextFormField(onChanged: (value){},),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
