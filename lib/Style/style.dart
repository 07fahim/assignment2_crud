import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const colorGrey = Color.fromRGBO(138, 134, 134, 1);
const colorBlue = Color.fromRGBO(191, 227, 245, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

ScreenBackground(context) {
  return SvgPicture.asset(
    "SVG_Background.svg",
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
    labelStyle: const TextStyle(color: colorGrey, fontSize: 18),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    hintText: label,
    hintStyle: const TextStyle(color: colorBlue),
  );
}
