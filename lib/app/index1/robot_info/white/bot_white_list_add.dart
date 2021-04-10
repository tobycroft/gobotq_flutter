import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index1/robot_info/white/url_white.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';
import 'package:gobotq_flutter/tuuz/ui/ui_button.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class Bot_white_list_add extends StatefulWidget {
  String _title;
  var _pageparam;

  Bot_white_list_add(this._title, this._pageparam);

  _Bot_white_list_add createState() => _Bot_white_list_add(this._title, this._pageparam);
}

class _Bot_white_list_add extends State<Bot_white_list_add> {
  String _title;
  var _pageparam;

  _Bot_white_list_add(this._title, this._pageparam);

  String gid;
  bool _gid = false;

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
          Container(
            child: Text("这里填写机器人可以加入的群"),
          ),
          Container(
            child: Text("如果不填写，机器人将无法拉入这个群"),
          ),
          Container(
            child: Text("机器人会定期退群，机器人将会自动退出未加入白名单的群"),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.account_circle, "输入机器人可以加入的群", this._gid, "请输入数字"),
            onChanged: (String val) {
              setState(() {
                if (int.tryParse(val) == null) {
                  this._gid = true;
                } else {
                  this._gid = false;
                }
              });
              this.gid = val.toString();
            },
          ),
          SizedBox(
            height: 50,
          ),
          UI_button.Button_submit(context, () async {
            Map post = await AuthAction().LoginObject();
            post["group_id"] = this.gid.toString();
            post["self_id"] = this._pageparam["self_id"].toString();
            String ret = await Net.Post(Config.Url, Url_white.white_add, null, post, null);
            Map json = jsonDecode(ret);
            if (Auth.Return_login_check(context, json)) {
              if (Ret.Check_isok(context, json)) {
                Alert.Confirm(context, json["echo"], json["echo"], () {
                  Windows.Close(this.context);
                });
              }
            }
          }),
        ],
      ),
    );
  }
}
