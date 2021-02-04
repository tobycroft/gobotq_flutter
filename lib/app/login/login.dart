import 'dart:convert';

import 'package:gobotq_flutter/config/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobotq_flutter/app/login/help/help.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/config/res.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/button/button.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/storage/storage.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _login();
}

class _login extends State<Login> {
  String qq;
  String password;

  @override
  Widget build(BuildContext context) {
    var uid_controller = new TextEditingController(text: "");
    var password_controller = new TextEditingController(text: "");
    uid_controller.addListener(() {
      this.qq = uid_controller.text;
    });

    //这里双向绑定简直是太蛋疼了
    password_controller.addListener(() {
      this.password = password_controller.text;
    });
    void initold() async {
      uid_controller.text = await Storage().Get("__uid__");

      password_controller.text = await Storage().Get("__password__");
    }

    initold();
    // void initState() {
    //   setState(() {
    //     var _con = new TextEditingController(text: "");
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 120,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "登录",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Tuuz_Button().BackWithWord(context),
        actions: [
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () {
                Windows().Open(context, Help());
              })
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.white,
          accentColor: Colors.amber,
        ),
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Res().Login_BG), fit: BoxFit.cover)),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "登录GoBotQ",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: uid_controller,
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white),
                  ),
                  filled: true,
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: "在这里输入你的QQ号码",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: 'QQ:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onChanged: (String value) {
                  this.qq = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: password_controller,
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white),
                  ),
                  filled: true,
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: "输入登录码",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: '登录码:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onChanged: (String value) {
                  this.password = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool value) {
                      // setState(() => this._checkBoxVal = value);
                    },
                    value: true,
                  ),
                  Text(
                    "用户守则",
                    style: TextStyle(
                      fontSize: Config().Font_size_text,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text('登录'),
                onPressed: () async {
                  Map<String, String> post = {
                    "qq": this.qq,
                    "password": this.password,
                  };
                  String ret = await Net().Post(Config().Url, Url().login, null, post, null);
                  var json = jsonDecode(ret);
                  if (json["code"] == 0) {
                    Storage().Set("__uid__", json["data"]["uid"].toString());
                    Storage().Set("__password__", this.password.toString());
                    Storage().Set("__token__", json["data"]["token"].toString());
                    Alert().Confirm(context, "登录成功", json["data"]["uid"].toString() + "欢迎回来！", Windows().Close(context));
                  } else {
                    Alert().Confirm(context, "登录失败", json["echo"], null);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
