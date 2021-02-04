import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gobotq_flutter/app/index2/group_setting/url_group_setting.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';

class GroupSettingSet extends StatefulWidget {
  var _pageparam;
  String _title;

  GroupSettingSet(this._title, this._pageparam);

  @override
  _GroupSettingSet createState() => _GroupSettingSet(this._title, this._pageparam);
}

List<Widget> _setting = [
  ListTile(
    leading: Icon(Icons.build),
    title: Text("等待数据载入"),
  )
];

class _GroupSettingSet extends State<GroupSettingSet> {
  var _pageparam;
  String _title;

  _GroupSettingSet(this._title, this._pageparam);

  @override
  void initState() {
    get_setting(context);
    super.initState();
  }

  Future<void> get_setting(BuildContext context) async {
    Map<String, dynamic> post = await AuthAction().LoginObject();
    post["gid"] = this._pageparam["gid"].toString();
    String ret = await Net().Post(Config().Url, Url_group_setting().Group_Setting_Get, null, post, null);
    Map json = jsonDecode(ret);
    if (Auth().Return_login_check(context, json)) {
      if (Ret().Check_isok(context, json)) {
        Map data = json["data"];
        _setting.clear();
        data.forEach((key, value) {
          switch (value["type"].toString()) {
            case "bool":
              {
                String str = "否";
                bool onoff = false;
                if (value["value"] == 1) {
                  str = "是";
                  onoff = true;
                }
                _setting.add(ListTile(
                  leading: Icon(Icons.build),
                  title: Text(value["name"].toString()),
                  subtitle: Text(str),
                  trailing: Switch(
                    value: onoff,
                    onChanged: (value) {
                      set_setting(context, key, value);
                    },
                  ),
                ));
                break;
              }

            case "int":
              {
                _setting.add(ListTile(
                  leading: Icon(Icons.build),
                  title: Text(value["name"].toString()),
                  subtitle: Text(value["value"].toString()),
                ));
                break;
              }

            case "string":
              {
                _setting.add(ListTile(
                  leading: Icon(Icons.build),
                  title: Text(value["name"].toString()),
                  subtitle: Text(value["value"].toString()),
                ));
                break;
              }

            default:
              {
                _setting.add(ListTile(
                  leading: Icon(Icons.build),
                  title: Text(value["name"].toString()),
                  subtitle: Text(value["value"].toString()),
                ));
                break;
              }
          }
        });
        setState(() {});
      }
    }
  }

  Future<void> set_setting(BuildContext context, String key, dynamic value) async {
    Map<String, dynamic> post = await AuthAction().LoginObject();
    post["gid"] = this._pageparam["gid"].toString();
    post["key"] = key;
    post["value"] = value;
    String ret = await Net().Post(Config().Url, Url_group_setting().Group_Setting_Get, null, post, null);
    Map json = jsonDecode(ret);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            this._title,
            style: Config().Text_style_title,
          ),
        ),
        body: EasyRefresh(
          child: ListView.builder(
            itemBuilder: (BuildContext con, int index) => _setting[index],
            itemCount: _setting.length,
          ),
          onRefresh: () async {
            get_setting(context);
          },
          firstRefresh: false,
        ));
  }
}
