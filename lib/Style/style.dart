import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

const colorGrey = Color.fromRGBO(138, 134, 134, 1);
const colorBlue = Color.fromRGBO(191, 227, 245, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

ScreenBackground(context) {
  return SvgPicture.asset(
    "assets/images/SVG_Background.svg",
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.cover,
  );
}

InputDecoration AddInputDecoration(label) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: colorWhite, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: colorBlue, width: 2)),
    labelText: label,
    labelStyle:GoogleFonts.merriweather(color: colorGrey, fontSize:20),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    hintText: label,
    hintStyle:GoogleFonts.merriweather(color: colorBlue),
  );
}

DecoratedBox AppDropDownStyle(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: colorWhite,
      border: Border.all(color: colorWhite, width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: child,
    ),
  );
}

ButtonStyle AppButtonStyle(){
  return ElevatedButton.styleFrom(
    backgroundColor:Colors.transparent,
    elevation: 1,
    padding: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
  );
}
