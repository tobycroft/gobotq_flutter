import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gobotq_flutter/config/config.dart';

class Upload_list extends StatefulWidget {
  String _title;

  Upload_list(this._title);

  _Upload_list createState() => _Upload_list(this._title);
}

class _Upload_list extends State<Upload_list> {
  String _title;

  _Upload_list(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config().Text_style_title,
        ),
      ),
      body: EasyRefresh(),
    );
  }
}
