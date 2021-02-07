import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Config {
  double Font_Size = 24;
  double Font_size_text = 16;

  TextStyle Text_Style_default = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  TextStyle Text_style_notimportant_auto = TextStyle(
    // fontSize: 16,
    color: Colors.black12,
  );

  TextStyle Text_style_Name = TextStyle(
    fontSize: 16,
  );

  TextStyle Text_style_title = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

  TextStyle Text_style_main_page = TextStyle(
    fontSize: 24,
  );

  TextStyle Text_style_input_box = TextStyle(
    fontSize: 24,
  );

  TextStyle Text_button_default = TextStyle(
    fontSize: 24,
  );

  ShapeBorder Shape_button_default = const RoundedRectangleBorder(
    side: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  );

  InputDecoration Inputdecoration_default_input_box(IconData icon, String labelText, bool error, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      prefixIcon: Icon(
        icon,
        size: 32,
      ),
      labelText: labelText,
      labelStyle: Text_style_input_box,
      errorText: error ? errorText : null,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  String ProxyURL = "http://10.0.0.100:9000";

  bool Proxy_debug = true;
  String Url = "127.0.0.1";

  // bool Proxy_debug = false;
  // String Url = "api.tuuz.cn:15088";
}
