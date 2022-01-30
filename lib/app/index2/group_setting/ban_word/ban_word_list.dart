import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gobotq_flutter/app/index2/group_setting/auto_reply/auto_reply_upload.dart';
import 'package:gobotq_flutter/app/index2/group_setting/auto_send/auto_send_set.dart';
import 'package:gobotq_flutter/app/index2/group_setting/auto_send/auto_send_upload.dart';
import 'package:gobotq_flutter/app/index2/group_setting/ban_word/ban_word_upload.dart';
import 'package:gobotq_flutter/app/index2/group_setting/url_group_setting.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class BanWord extends StatefulWidget {
  String _title;
  var _pageparam;

  BanWord(this._title, this._pageparam);

  _BanWord createState() => _BanWord(this._title, this._pageparam);
}

class _BanWord extends State<BanWord> {
  String _title;
  var _pageparam;

  _BanWord(this._title, this._pageparam);

  @override
  void initState() {
    setState(() {
      get_data(context, this._pageparam["group_id"].toString());
    });

    super.initState();
  }

  Future<void> get_data(BuildContext context, String gid) async {
    Map post = await AuthAction().LoginObject();
    post["group_id"] = gid;

    String ret = await Net.Post(Config.Url, Url_group_setting.Group_word_list, null, post, null);
    Map json = jsonDecode(ret);
    if (Auth.Return_login_check(context, json)) {
      if (Ret.Check_isok(context, json)) {
        _data_list = json["data"];
        setState(() {
          _data_list = json["data"];
        });
      }
    }
  }

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
              Windows.Open(context, BanWordUpload("新增屏蔽", this._pageparam));
            },
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: EasyRefresh(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var _data = _data_list[index];
            String type = "";
            if (_data["type"].toString() == "sep") {
              type = "时间间隔模式";
            } else {
              type = "一次性触发模式";
            }
            return new Slidable(
              actionPane: SlidableScrollActionPane(),
              //滑出选项的面板 动画
              actionExtentRatio: 0.25,
              child: ListTile(
                title: Row(children: [
                  Text("类型：" + type),
                ]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("模式：" + (_data["mode"].toString() == "1" ? "部分匹配" : "全部匹配")),
                    Text("触发后禁言（或扣分）：" + (_data["mode"].toString() == "1" ? "是" : "否")),
                    Text("触发后T出：" + (_data["mode"].toString() == "1" ? "是" : "否")),
                    Text("出发后撤回：" + (_data["mode"].toString() == "1" ? "是" : "否")),
                    Text("可与其他人共享：" + (_data["mode"].toString() == "1" ? "是" : "否")),
                    Text("设定人（QQ）：" + _data["user_id"].toString()),
                    Text("屏蔽词：\n" + _data["word"].toString())
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("设定时间：" + _data["date"].toString()),
                    Text("修改时间：" + _data["change_date"].toString()),
                  ],
                ),
                onTap: () async {
                  // Windows.Open(context, AutoSendSet("修改自动发送", _data));
                },
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete_forever,
                  onTap: () async {
                    bool ret = await delete_data(context, _data["id"].toString(), _data["group_id"].toString());
                    if (ret) {
                      setState(() {
                        _data_list.removeAt(index);
                      });
                    }
                  },
                )
              ],
            );
          },
          itemCount: _data_list.length,
        ),
        onRefresh: () async {
          get_data(context, this._pageparam["group_id"].toString());
        },
      ),
    );
  }
}

Future<bool> delete_data(BuildContext context, String id, gid) async {
  Map post = await AuthAction().LoginObject();
  post["id"] = id;
  post["group_id"] = gid;

  String ret = await Net.Post(Config.Url, Url_group_setting.Group_word_delete, null, post, null);
  Map json = jsonDecode(ret);
  if (Auth.Return_login_check(context, json)) {
    if (Ret.Check_isok(context, json)) {
      Alert.Confirm(context, json["echo"], json["echo"], () {});
      return true;
    }
  }
  return false;
}

List _data_list = [];
