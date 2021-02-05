import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index1/robot_info/url_robot_info.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';

class Robot_info_index extends StatefulWidget {
  var _page_param;

  Robot_info_index(this._page_param);

  @override
  State<StatefulWidget> createState() => _robot_info_index(this._page_param);
}

Map _robot_info = {};

class _robot_info_index extends State<Robot_info_index> {
  var _page_param;

  _robot_info_index(this._page_param);

  @override
  void initState() {
    get_robot_info();
    super.initState();
  }

  Future<void> get_robot_info() async {
    Map post = await AuthAction().LoginObject();
    post["gid"] = this._page_param["bot"].toString();
    String ret = await Net().Post(Config().Url, Url_robot_info().Robot_info, null, post, null);
    Map json = jsonDecode(ret);
    if (Auth().Return_login_check(context, json)) {
      if (Ret().Check_isok(context, json)) {
        setState(() {
          _robot_info = json["data"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("机器人设定"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.zero,
            height: 150,
            // color: Colors.black,
            child: Stack(
              children: [
                Container(
                  color: Colors.green,
                  height: 100,
                ),
                Center(
                  child: ClipOval(
                    //圆形头像
                    child: Image.network(
                      this._page_param["img"].toString(),
                      width: 100,
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Text(
                //       "123",
                //       style: TextStyle(color: Colors.white, fontSize: Config().Font_Size),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          ListTile(
            leading: ClipOval(
              //圆形头像
              child: Image.network(
                _robot_info["img"].toString(),
                width: 40,
              ),
            ),
            title: Text("机器人账号"),
            subtitle: Text(
              _robot_info["bot"].toString(),
              style: Config().Text_style_notimportant_auto,
            ),
            // trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(
              Icons.timer_off,
              size: 40,
            ),
            title: Text("机器人剩余使用时间"),
            subtitle: Text(
              "",
              style: Config().Text_style_notimportant_auto,
            ),
            trailing: Icon(Icons.chevron_right),
            // trailing: Icon(Icons.chevron_right),
            onTap: () async {
              Alert().Confirm(context, "title", "content", () {});
            },
          ),
          ListTile(
            leading: Icon(
              Icons.drive_file_rename_outline,
              size: 40,
            ),
            title: Text("修改机器人名称"),
            subtitle: Text(
              "修改机器人的显示名称",
              style: Config().Text_style_notimportant_auto,
            ),
            trailing: Icon(Icons.chevron_right),
            // trailing: Icon(Icons.chevron_right),
            onTap: () async {
              Alert().Confirm(context, "title", "content", () {});
            },
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              size: 40,
            ),
            title: Text(
              "修改机器人头像",
            ),
            subtitle: Text(
              "这将会修改机器人的头像",
              style: Config().Text_style_notimportant_auto,
            ),
            trailing: Icon(Icons.chevron_right),
            // trailing: Icon(Icons.chevron_right),
            onTap: () async {
              Alert().Confirm(context, "title", "content", () {});
            },
          ),
        ],
      ),
    );
  }
}
