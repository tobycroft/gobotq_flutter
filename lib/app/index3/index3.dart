import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobotq_flutter/app/index3/upload_robot/upload_robot.dart';
import 'package:gobotq_flutter/app/index3/upload_server/upload_server.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class Index3 extends StatefulWidget {
  String _title;

  Index3(this._title);

  _Index3 createState() => _Index3(this._title);
}

class _Index3 extends State<Index3> {
  String _title;

  _Index3(this._title);

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
        crossAxisCount: 2,
        children: [
          FlatButton(
            color: Colors.black87,
            splashColor: Colors.white,
            textColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt,
                  size: 80,
                ),
                Text(
                  "申请官方服务器",
                  style: Config.Text_style_main_page,
                ),
              ],
            ),
            onPressed: () async {
              Windows.Open(context, Upload_robot("提交私有机器人账号"));
            },
          ),
          FlatButton(
            color: Colors.black87,
            splashColor: Colors.white,
            textColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.device_hub,
                  size: 80,
                ),
                Text(
                  "提交你的服务器",
                  style: Config.Text_style_main_page,
                ),
              ],
            ),
            onPressed: () async {
              Windows.Open(context, Upload_server("加入主网"));
            },
          ),
        ],
      ),
    );
  }
}
