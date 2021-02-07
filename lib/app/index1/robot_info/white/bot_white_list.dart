import 'package:flutter/material.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/extend/authaction/authaction.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';

class BotWhiteList extends StatefulWidget {
  String _title;
  var _pageparam;

  BotWhiteList(this._title, this._pageparam);

  _BotWhiteList createState() => _BotWhiteList(this._title, this._pageparam);
}

class _BotWhiteList extends State<BotWhiteList> {
  String _title;
  var _pageparam;

  _BotWhiteList(this._title, this._pageparam);

  Future<void> get_data() async {
    Map post =AuthAction().LoginObject();
    post["bot"]=this._pageparam["bot"];
    
    String ret=Net().Post(Config().Url, , get, post, header)
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this._title,
          style: Config().Text_style_title,
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
      body: null,
    );
  }
}

List _white_group = [];

class _list_builder extends StatelessWidget {
  BuildContext context;
  var _index;
  var _pageparam;

  _list_builder(this.context, this._index, this._pageparam);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this._index.toString()),
      child: ListTile(
        leading: null,
        title: this._pageparam,
        subtitle: this._pageparam,
        trailing: null,
        onTap: () async {},
      ),
    );
  }
}
