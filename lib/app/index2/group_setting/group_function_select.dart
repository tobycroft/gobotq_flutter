import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index2/group_setting/group_black_list.dart';
import 'package:gobotq_flutter/app/index2/group_setting/group_setting_set.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class GroupFunctionSelect extends StatefulWidget {
  String _title;
  var _pageparam;

  GroupFunctionSelect(this._title, this._pageparam);

  _GroupFunctionSelect createState() => _GroupFunctionSelect(this._title, this._pageparam);
}

class _GroupFunctionSelect extends State<GroupFunctionSelect> {
  String _title;
  var _pageparam;

  _GroupFunctionSelect(this._title, this._pageparam);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config.Text_style_title,
        ),
      ),
      body: GridView.count(
          padding: EdgeInsets.all(0),
          physics: new NeverScrollableScrollPhysics(),
          //增加
          shrinkWrap: false,
          //增加
          crossAxisCount: 2,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 80,
                  ),
                  Text(
                    "群设定",
                    style: Config.Text_style_main_page,
                  )
                ],
              ),
              onPressed: () async {
                Windows.Open(context, GroupSettingSet("群设定", this._pageparam));
              },
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.nature_people,
                    size: 80,
                  ),
                  Text(
                    "群黑名单",
                    style: Config.Text_style_main_page,
                  )
                ],
              ),
              onPressed: () async {
                Windows.Open(context, GroupBlackList("群黑名单", this._pageparam));
              },
            ),
            FlatButton(
              color: Colors.amber,
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.reply,
                    size: 80,
                  ),
                  Text(
                    "关键词回复",
                    style: Config.Text_style_main_page,
                  )
                ],
              ),
              onPressed: () async {},
            ),
            FlatButton(
              color: Colors.lime,
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.reply_all,
                    size: 80,
                  ),
                  Text(
                    "全字匹配回复",
                    style: Config.Text_style_main_page,
                  )
                ],
              ),
              onPressed: () async {},
            ),
          ]),
    );
  }
}
