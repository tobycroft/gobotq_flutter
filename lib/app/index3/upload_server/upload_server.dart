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
  String address;
  String port;
  String secret;

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
            child: Text("注意事项："),
          ),
          Container(
            child: Text("可以自助提交主网，提交后请在开发群542749156中联系管理告知"),
          ),
          Container(
            child: Text("接口基于CoolQ，你可以使用go-cqhttp，为了让大家可以避免出现一些奇怪的问题，你可以直接使用群共享中已经编译好的程序，使用方法，请参考官方github"),
          ),
          Container(
            child: Text("请先设定您的cq_http客户端的远程上报地址为:api.tuuz.cc:15081，本地址一定要正确填写，GobotQ将无法接收到您的Event"),
          ),
          Container(
            child: Text("每个管理账号，只可提交一次，提交后无法删除"),
          ),
          Container(
            child: Text("更换接口操作可以在APP中完成"),
          ),
          Container(
            child: Text("因为没有使用秘钥，所以请不要将你的cqhttp的api对外暴露避免造成风险，GobotQ官方已经对接口做了安全处理，你的服务器不会被泄露给第三方，可以放心使用！"),
          ),
          Container(
            child: Text("我们将在未来的版本中，支持远程服务器的秘钥功能"),
          ),
          Container(
            child: Text("使用时长：你可以无限续签你的服务器，但是每次续签时间在1年以内"),
          ),
          Container(
            child: Text(
              "使用敬告：请不要在使用GobotQ远程版的过程中将你的外网端口封闭，如果每一次远程接口访问失败都会累积故障阈值，如果您封闭了您的外网端口，在错误值累积到一定数量后，"
                  "GobotQ将会把您的账号拉黑，您就需要换一个机器人账号使用了！\r\n"
                  "如果您是使用动态IP+域名映射的方式连入GoBotQ，请您务必在域名TTL过期后再连入GoBotQ",
              style: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text("这里填写内容例如：robot.你的域名.com，或者如果你没有域名也可以使用ip,不要在前面加http或加斜杠等任何多余的内容"),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.security_outlined, "输入机器人服务器地址", false, ""),
            onChanged: (String val) {
              this.address = val.toString();
            },
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text("输入cq_http对外暴露的端口"),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.security_outlined, "输入服务器端口", false, ""),
            onChanged: (String val) {
              this.port = val.toString();
            },
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text("你可以设定一个密钥，用于后期使用acfur绑定功能"),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline4,
            decoration: Config.Inputdecoration_default_input_box(Icons.security_outlined, "设定绑定密钥", false, ""),
            onChanged: (String val) {
              this.secret = val.toString();
            },
          ),
          SizedBox(
            height: 40,
          ),
          UI_button.Button_submit(context, () async {
            Map post = await AuthAction().LoginObject();
            post["self_id"] = this.qq.toString();
            post["address"] = this.address.toString();
            post["port"] = this.port.toString();
            post["secret"] = this.secret.toString();
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
