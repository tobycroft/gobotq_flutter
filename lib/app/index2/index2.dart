import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index2/url_index2.dart';
import 'package:gobotq_flutter/config/auth.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';

class Index2 extends StatelessWidget {
  String _title;

  Index2(this._title);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      ListView(
        children: [],
      ),
      const Center(child: Icon(Icons.add_box, size: 64.0, color: Colors.cyan)),
    ];
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.check_box), text: '可控制'),
      const Tab(icon: Icon(Icons.check_box_outline_blank), text: '仅查看'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this._title),
          backgroundColor: Colors.black,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}

List _group_control = [];
List _group_joined = [];

void group_control(BuildContext context) async {
  Map post = await AuthAction().LoginObject();
  String ret = await Net().Post(Config().Url, Url_Index2().Group_list_control, null, post, null);
  Map json = jsonDecode(ret);
  if (Auth().Return_login_check(context, json)) {
    if (json["code"] == 0) {

    }else{
      Alert()
    }
  }
}

void group_joined(BuildContext context) async {}
