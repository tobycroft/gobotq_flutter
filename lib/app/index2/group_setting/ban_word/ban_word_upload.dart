import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index2/group_setting/url_group_setting.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';
import 'package:gobotq_flutter/tuuz/ui/ui_button.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class BanWordUpload extends StatefulWidget {
  String _title;
  var _pageparam;

  BanWordUpload(this._title, this._pageparam);

  _BanWordUpload createState() => _BanWordUpload(this._title, this._pageparam);
}

class _BanWordUpload extends State<BanWordUpload> {
  String _title;
  var _pageparam;

  _BanWordUpload(this._title, this._pageparam);

  String ident;
  String msg;
  String sep;
  int count;
  String type = "sep";
  bool retract = true;
  int _radioVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config.Text_style_title,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            maxLength: 64,
            decoration: Config.Inputdecoration_default_input_box(Icons.av_timer, "标识符（相同的自动组合）", false, "任意字符"),
            onChanged: (String val) {
              this.ident = val.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline4,
            maxLength: 64,
            decoration: Config.Inputdecoration_default_input_box(Icons.av_timer, "间隔时间(分钟)", true, "请输入数字"),
            onChanged: (String val) {
              this.sep = val.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline4,
            maxLength: 64,
            decoration: Config.Inputdecoration_default_input_box(Icons.av_timer, "重复次数", false, "任意字符"),
            onChanged: (String val) {
              this.count = int.parse(val);
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            maxLines: 6,
            maxLength: 1000,
            decoration: Config.Inputdecoration_default_input_box(Icons.text_fields, "输入自动发送的内容", false, "请输入文字"),
            onChanged: (String val) {
              this.msg = val.toString();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "触发模式:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("间隔模式"),
              Radio(
                value: "sep",
                groupValue: this.type,
                onChanged: (value) {
                  setState(() {
                    this.type = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("一次性模式"),
              Radio(
                value: "fix",
                groupValue: this.type,
                onChanged: (value) {
                  setState(() {
                    this.type = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "自动撤回:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("自动撤回"),
              Radio(
                value: true,
                groupValue: this.retract,
                onChanged: (value) {
                  setState(() {
                    this.retract = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("不自动撤回"),
              Radio(
                value: false,
                groupValue: this.retract,
                onChanged: (value) {
                  setState(() {
                    this.retract = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          UI_button.Button_submit(context, () async {
            Map post = await AuthAction().LoginObject();
            post["group_id"] = this._pageparam["group_id"].toString();
            post["ident"] = this.ident.toString();
            post["msg"] = this.msg.toString();
            post["sep"] = this.sep.toString();
            post["count"] = this.count.toString();
            post["type"] = this.type.toString();
            post["retract"] = this.retract.toString();
            String ret = await Net.Post(Config.Url, Url_group_setting.Group_AutoSend_add, null, post, null);
            Map json = jsonDecode(ret);
            if (Auth.Return_login_check(context, json)) {
              if (Ret.Check_isok(context, json)) {
                Alert.Confirm(context, json["echo"], json["echo"], () {
                  Windows.Close(this.context);
                });
              }
            }
          }),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
