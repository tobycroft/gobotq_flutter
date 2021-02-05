import 'package:flutter/material.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/tuuz/ui/ui.dart';

class UI_button extends UI {
  RaisedButton Submit_button(BuildContext context, VoidCallback func) {
    return RaisedButton(
      padding: EdgeInsets.all(10),
      color: Colors.lightGreen,
      child: Text(
        "提交",
        style: Config().Text_button_default,
      ),
      onPressed: func,
      shape: Config().Shape_button_default,
    );
  }
}
