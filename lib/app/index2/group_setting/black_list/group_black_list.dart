import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gobotq_flutter/app/index2/group_setting/url_group_setting.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:gobotq_flutter/tuuz/net/ret.dart';

class GroupBlackList extends StatefulWidget {
  String _title;
  var _pageparam;

  GroupBlackList(this._title, this._pageparam);

  _GroupBlackList createState() => _GroupBlackList(this._title, this._pageparam);
}

class _GroupBlackList extends State<GroupBlackList> {
  String _title;
  var _pageparam;

  _GroupBlackList(this._title, this._pageparam);

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

    String ret = await Net.Post(Config.Url, Url_group_setting.Group_black_list, null, post, null);
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
            onPressed: () async {},
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
            var _data = _white_group[index];

            return new Slidable(
              actionPane: SlidableScrollActionPane(),
              //滑出选项的面板 动画
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: null,
                title: Text(_data["user_id"].toString()),
                subtitle: Text("操作人：" + _data["operator"].toString()),
                trailing: Text(_data["date"].toString()),
                onTap: () async {},
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete_forever,
                  onTap: () async {
                    bool ret = await delete_data(context, _data["user_id"].toString(), _data["group_id"].toString());
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
          get_data(context, this._pageparam["group_id"].toString());
        },
      ),
    );
  }
}

Future<bool> delete_data(BuildContext context, String uid, gid) async {
  Map post = await AuthAction().LoginObject();
  post["qq"] = uid;
  post["group_id"] = gid;

  String ret = await Net.Post(Config.Url, Url_group_setting.Group_black_delete, null, post, null);
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
