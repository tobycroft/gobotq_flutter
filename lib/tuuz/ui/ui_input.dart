import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/tuuz/ui/ui.dart';

class Ui_input extends UI {
  Widget TextBox(BuildContext context, TextInputType type, Icon icon, String label) {
    return TextField(
      keyboardType: type,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        icon: icon,
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
