
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

const colorGrey = Color.fromRGBO(138, 134, 134, 1);
const colorBlue = Color.fromRGBO(192, 227, 245, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

const darkBackgroundColor = Color.fromRGBO(33, 33, 33, 1);
const darkCardColor = Color.fromRGBO(66, 66, 66, 1);
const darkTextColor = Color.fromRGBO(255, 255, 255, 0.87);
const darkIconColor = Color.fromRGBO(255, 255, 255, 0.6);

Widget ScreenBackground(BuildContext context, bool isDarkMode) {
  print('ScreenBackground called with isDarkMode: $isDarkMode'); // Debug log

  return Stack(
    children: [
      // Base background color
      Container(
        color: isDarkMode ? darkBackgroundColor : Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      // SVG overlay
      SvgPicture.asset(
        isDarkMode
            ? "assets/images/dark-waves.svg"
            : "assets/images/SVG_Background.svg",
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    ],
  );
}

InputDecoration AddInputDecoration(String label, bool isDarkMode) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: isDarkMode ? darkCardColor : colorBlue,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: isDarkMode ? darkCardColor : colorWhite,
        width: 0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: isDarkMode ? darkTextColor : colorBlue,
        width: 2,
      ),
    ),
    labelText: label,
    labelStyle: GoogleFonts.merriweather(
      color: isDarkMode ? darkIconColor : colorGrey,
      fontSize: 20,
    ),
    fillColor: isDarkMode ? darkCardColor : Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    hintText: label,
    hintStyle: GoogleFonts.merriweather(
      color: isDarkMode ? darkIconColor : colorBlue,
    ),
  );
}

DecoratedBox AppDropDownStyle(Widget child, bool isDarkMode) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: isDarkMode ? darkCardColor : colorWhite,
      border: Border.all(
        color: isDarkMode ? darkCardColor : colorWhite,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: child,
    ),
  );
}

ButtonStyle AppButtonStyle(bool isDarkMode) {
  return ElevatedButton.styleFrom(
    backgroundColor: isDarkMode ? darkCardColor : Colors.transparent,
    elevation: 1,
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

Ink EleButtonChild(String ButtonText, {bool isDarkMode = false}) {
  return Ink(
    decoration: BoxDecoration(
      color: isDarkMode ? darkCardColor : colorDarkBlue,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        ButtonText,
        style: GoogleFonts.firaSans(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: isDarkMode ? darkTextColor : colorWhite,
        ),
      ),
    ),
  );
}