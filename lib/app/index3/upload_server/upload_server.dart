import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index3/Upload_server/upload_list.dart';
import 'package:gobotq_flutter/app/index3/upload_server/url_upload_server.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';
import 'package:gobotq_flutter/tuuz/ui/ui_button.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class Upload_server extends StatefulWidget {
  String _title;

  Upload_server(this._title);

  _Upload_server createState() => _Upload_server(this._title);
}

class _Upload_server extends State<Upload_server> {
  String _title;

  _Upload_server(this._title);

  String qq;
  bool _qq = false;
  String password;
  String secret;
  double month = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config.Text_style_title,
        ),
        actions: [
          FlatButton(
              onPressed: () async {
                Windows.Open(context, Upload_list("机器人提交记录"));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "提交记录",
                    style: Config.Text_style_title.copyWith(
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
          Container(
            child: Text("可以自助提交主网，提交后请在开发群542749156中联系管理告知"),
          ),
          Container(
            child: Text("接口基于CoolQ，你可以使用go-cqhttp，为了让大家可以避免出现一些奇怪的问题，你可以直接使用群共享中已经编译好的程序，使用方法，请参考官方github"),
          ),
          Container(
            child: Text("请先设定您的cq_http客户端的远程提交地址为:http://api.tuuz.cc:15081"),
          ),
          Container(
            child: Text("每个管理账号，只可提交一次，提交后无法删除"),
          ),
          Container(
            child: Text("更换接口操作可以在APP中完成"),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.account_circle, "输入机器人的QQ号码", this._qq, "请输入数字"),
            onChanged: (String val) {
              setState(() {
                if (int.tryParse(val) == null) {
                  this._qq = true;
                } else {
                  this._qq = false;
                }
              });
              this.qq = val.toString();
            },
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.security, "输入机器人QQ密码", false, "请输入数字"),
            onChanged: (String val) {
              this.password = val.toString();
            },
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text("你可以设定一个密钥，用于后期使用acfur绑定功能"),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.security_outlined, "设定绑定密钥", false, ""),
            onChanged: (String val) {
              this.secret = val.toString();
            },
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "预定时长:${month.round()}个月",
            style: Config.Text_style_main_page,
          ),
          SizedBox(
            height: 40,
          ),
          Slider(
            min: 1,
            max: 12,
            divisions: 11,
            label: '${month.round()}个月',
            value: month,
            onChanged: (double val) {
              setState(() {
                month = val;
                // month = double.parse(val.round().toString());
                // print(month);
              });
            },
          ),
          SizedBox(
            height: 80,
          ),
          UI_button.Button_submit(context, () async {
            Map post = await AuthAction().LoginObject();
            post["self_id"] = this.qq.toString();
            post["password"] = this.password.toString();
            post["secret"] = this.secret.toString();
            post["month"] = month.round().toString();
            String ret = await Net.Post(Config.Url, Url_upload_server.Upload_server, null, post, null);
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
