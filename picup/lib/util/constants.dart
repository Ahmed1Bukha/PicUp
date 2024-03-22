import 'package:flutter/material.dart';

class ColorConstants {
  static const PRIMARY_500 = Color(0xff023E33);
  static const PRIMARY_400 = Color(0xff237365);
  static const PRIMARY_300 = Color(0xff00B997);
  static const PRIMARY_200 = Color(0xff07F8CC);
  static const PRIMARY_100 = Color(0xffB3FFF1);
  static const PRIMARY_50 = Color(0xffE1FFFA);
  static const ERROR_COLOR = (Color.fromARGB(255, 255, 99, 88));
}

class TextHeadersContatns {
  static const h1 = TextStyle(fontSize: 64, fontFamily: "Rubik");
  static const h2 = TextStyle(fontSize: 46, fontFamily: "Rubik");
  static const h3 = TextStyle(fontSize: 32, fontFamily: "Rubik");
  static const h4 = TextStyle(fontSize: 24, fontFamily: "Rubik");
  static const h5 = TextStyle(fontSize: 20, fontFamily: "Rubik");
}

class TextBodyConstants {
  static const regular20 = TextStyle(fontSize: 20, fontFamily: "Inter");
  static const bold20 =
      TextStyle(fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.bold);

  static const regular16 = TextStyle(fontSize: 16, fontFamily: "Inter");
  static const bold16 =
      TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.bold);

  static const regular14 = TextStyle(fontSize: 14, fontFamily: "Inter");
  static const bold14 =
      TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.bold);

  static const regular12 = TextStyle(fontSize: 12, fontFamily: "Inter");
  static const bold12 =
      TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.bold);
}
