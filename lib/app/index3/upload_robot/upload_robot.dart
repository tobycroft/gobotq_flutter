import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/tuuz/ui/ui_input.dart';

class Upload_robot extends StatefulWidget {
  String _title;

  Upload_robot(this._title);

  _Upload_robot createState() => _Upload_robot(this._title);
}

class _Upload_robot extends State<Upload_robot> {
  String _title;

  _Upload_robot(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config().Text_style_title,
        ),
        actions: [
          FlatButton(
              onPressed: () async {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "提交记录",
                    style: Config().Text_style_title.copyWith(
                          fontSize: 17,
                        ),
                  ),
                  Icon(
                    Icons.format_list_bulleted,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              )),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config().Inputdecoration_default_input_box(Icons.account_circle, "输入机器人的QQ号码"),
          ),
        ],
      ),
    );
  }
}
