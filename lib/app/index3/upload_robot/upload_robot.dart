import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/ui/ui_button.dart';

class Upload_robot extends StatefulWidget {
  String _title;

  Upload_robot(this._title);

  _Upload_robot createState() => _Upload_robot(this._title);
}

class _Upload_robot extends State<Upload_robot> {
  String _title;

  _Upload_robot(this._title);

  String qq;
  String password;
  String secret;
  String time;

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
          Container(
            child: Text("您需要积分才能提交机器人，请关注您的积分剩余"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            decoration: Config().Inputdecoration_default_input_box(Icons.account_circle, "输入机器人的QQ号码"),
            onChanged: (String val) {
              this.qq = val.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            decoration: Config().Inputdecoration_default_input_box(Icons.security, "输入机器人QQ密码"),
            onChanged: (String val) {
              this.password = val.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text("你可以设定一个密钥，用于后期使用acfur绑定功能"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.text,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            decoration: Config().Inputdecoration_default_input_box(Icons.security_outlined, "设定绑定密钥"),
            onChanged: (String val) {
              this.secret = val.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          UI_button().Button_submit(context, () async {
            Net().Post(Config().Url, path, get, post, header)
          }),
        ],
      ),
    );
  }
}
