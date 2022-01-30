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

  String word;
  int mode = 0;
  bool is_ban = true;
  bool is_kick = false;
  bool share = false;
  bool is_retract = true;

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
          Text(
            "触发模式:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("全字匹配"),
              Radio(
                value: 0,
                groupValue: this.mode,
                onChanged: (value) {
                  setState(() {
                    this.mode = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("部分匹配"),
              Radio(
                value: 1,
                groupValue: this.mode,
                onChanged: (value) {
                  setState(() {
                    this.mode = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "触发后禁言:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("禁言或扣分"),
              Radio(
                value: true,
                groupValue: this.is_ban,
                onChanged: (value) {
                  setState(() {
                    this.is_ban = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("不禁言"),
              Radio(
                value: false,
                groupValue: this.is_ban,
                onChanged: (value) {
                  setState(() {
                    this.is_ban = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "触发后T出:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("T出群成员"),
              Radio(
                value: true,
                groupValue: this.is_kick,
                onChanged: (value) {
                  setState(() {
                    this.is_kick = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("不T出群成员"),
              Radio(
                value: false,
                groupValue: this.is_kick,
                onChanged: (value) {
                  setState(() {
                    this.is_kick = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "触发后T撤回:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("撤回该条消息"),
              Radio(
                value: true,
                groupValue: this.is_retract,
                onChanged: (value) {
                  setState(() {
                    this.is_retract = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("不撤回"),
              Radio(
                value: false,
                groupValue: this.is_retract,
                onChanged: (value) {
                  setState(() {
                    this.is_retract = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "分享本条设定:",
            style: Config.Text_style_input_box,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("分享给其他用户"),
              Radio(
                value: true,
                groupValue: this.share,
                onChanged: (value) {
                  setState(() {
                    this.share = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("不分享"),
              Radio(
                value: false,
                groupValue: this.share,
                onChanged: (value) {
                  setState(() {
                    this.share = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            maxLines: 6,
            maxLength: 1000,
            decoration: Config.Inputdecoration_default_input_box(Icons.text_fields, "在这里输入你需要屏蔽的词句", false, "请输入文字"),
            onChanged: (String val) {
              this.word = val.toString();
            },
          ),
          SizedBox(
            height: 20,
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
          SizedBox(
            height: 40,
          ),
          UI_button.Button_submit(context, () async {
            Map post = await AuthAction().LoginObject();
            post["group_id"] = this._pageparam["group_id"].toString();
            post["share"] = this.share.toString();
            post["is_retract"] = this.is_retract.toString();
            post["is_kick"] = this.is_kick.toString();
            post["is_ban"] = this.is_ban.toString();
            post["mode"] = this.mode.toString();
            post["word"] = this.word.toString();
            String ret = await Net.Post(Config.Url, Url_group_setting.Group_word_add, null, post, null);
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
