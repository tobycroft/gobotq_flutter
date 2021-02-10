import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gobotq_flutter/app/index1/robot_info/list/bot_group_list_add.dart';
import 'package:gobotq_flutter/app/index1/robot_info/list/url_list.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class BotGroupList extends StatefulWidget {
  String _title;
  var _pageparam;

  BotGroupList(this._title, this._pageparam);

  _BotGroupList createState() => _BotGroupList(this._title, this._pageparam);
}

class _BotGroupList extends State<BotGroupList> {
  String _title;
  var _pageparam;

  _BotGroupList(this._title, this._pageparam);

  @override
  void initState() {
    setState(() {
      get_data(context, this._pageparam["bot"].toString());
    });
    super.initState();
  }

  Future<void> get_data(BuildContext context, String bot) async {
    Map post = await AuthAction().LoginObject();
    post["bot"] = bot;

    String ret = await Net.Post(Config.Url, Url_List.group_list, null, post, null);
    Map json = jsonDecode(ret);
    if (Auth.Return_login_check(context, json)) {
      if (Ret.Check_isok(context, json)) {
        _white_group = json["data"];
        setState(() {
          _white_group = json["data"];
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
              Windows.Open(context, Bot_group_list_add(this._title, this._pageparam));
            },
            child: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: EasyRefresh(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var _data = _white_group[index];

            return new Slidable(
              actionPane: SlidableScrollActionPane(),
              //滑出选项的面板 动画
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: null,
                title: Text(_data["group_name"].toString()),
                subtitle: Text(_data["gid"].toString()),
                trailing: null,
                onTap: () async {},
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete_forever,
                  onTap: () async {
                    bool ret = await delete_data(context, _data["bot"].toString(), _data["gid"].toString());
                    if (ret) {
                      setState(() {
                        _white_group.removeAt(index);
                      });
                    }
                  },
                )
              ],
            );
          },
          itemCount: _white_group.length,
        ),
        onRefresh: () async {
          get_data(context, this._pageparam["bot"].toString());
        },
      ),
    );
  }
}

Future<bool> delete_data(BuildContext context, String bot, gid) async {
  Map post = await AuthAction().LoginObject();
  post["bot"] = bot;
  post["gid"] = gid;

  String ret = await Net.Post(Config.Url, Url_List.group_exit, null, post, null);
  Map json = jsonDecode(ret);
  if (Auth.Return_login_check(context, json)) {
    if (Ret.Check_isok(context, json)) {
      Alert.Confirm(context, json["echo"], json["echo"], () {});
      return true;
    }
  }
  return false;
}

List _white_group = [];
