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
  );

  String ProxyURL = "http://10.0.0.100:9000";

  bool Proxy_debug = true;
  // bool Proxy_debug = false;

  // String Url = "api.tuuz.cn:15088";
  String Url = "127.0.0.1";
}
