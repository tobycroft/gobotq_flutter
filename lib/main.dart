import 'dart:convert';
import 'dart:io';

import 'package:event_hub/event_hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobotq_flutter/app/index1/index1.dart';
import 'package:gobotq_flutter/app/index2/index2.dart';
import 'package:gobotq_flutter/app/index3/index3.dart';
import 'package:gobotq_flutter/app/index4/index4.dart';
import 'package:gobotq_flutter/config/config.dart';
import 'package:gobotq_flutter/config/url.dart';
import 'package:gobotq_flutter/tuuz/alert/ios.dart';
import 'package:gobotq_flutter/tuuz/net/net.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:gobotq_flutter/config/style.dart' as st;
import 'package:package_info/package_info.dart';
import 'package:path/path.dart';
import 'package:r_upgrade/r_upgrade.dart';

void main() {
  runApp(MyApp());
}

final JPush jpush = new JPush();

final EventHub eventhub = EventHub();

class Init {
  void init(BuildContext context) async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print(packageInfo.appName);
    // print(packageInfo.version);
      PackageInfo info = await PackageInfo.fromPlatform();
      int version_code = int.tryParse(info.buildNumber);
      Map<String, String> post = {
        "platform": Platform.operatingSystem.toString(),
        "dart": Platform.version.toString(),
        "system": Platform.operatingSystemVersion.toString(),
        "version": info.version,
        "version_code": version_code.toString(),
        "package_name": info.packageName,
        "appname": info.appName,
      };

      String ret = await Net.Post(Config.Url, Url.Update_path, null, post, null);
      Map json = jsonDecode(ret);
      if (json["code"] == 0) {
        Map data = json["data"];

        if (version_code < int.parse(data["version"])) {
          String upgrade_text = "";
          upgrade_text += "当权版本：";
          upgrade_text += info.version.toString() + "\r\n";
          upgrade_text += "有新版本：";
          upgrade_text += data["show_ver"].toString() + "\r\n";

          upgrade_text += "更新内容：\r\n";
          upgrade_text += data["upgrade_text"].toString() + "\r\n";

          upgrade_text += "更新日期:" + data["date"].toString();

          Alert.Simple(context, "有新的更新", upgrade_text, () {
            RUpgrade.upgrade(
              data["url"].toString(),
              fileName: data["file"].toString(),
              isAutoRequestInstall: true,
              notificationStyle: NotificationStyle.speechAndPlanTime,
              useDownloadManager: false,
            );
          });
        } else {
          // Alert.Confirm(context, "没有新的更新了", "", () {});
        }
      }
  }

  void is_login() async {}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark().copyWith(
        dividerTheme: DividerThemeData(
          color: Colors.black12,
          thickness: 0.5,
          space: 0.5,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
      ),
      theme: ThemeData(
        // primaryColor: Colors.grey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: st.Style.LightGrey,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white54,
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: st.Style.LightGrey),
        dividerTheme: DividerThemeData(
          color: st.Style.LightGrey,
          thickness: 0.3,
          space: 0.5,
        ),
        backgroundColor: Colors.white,
      ),
      home: BotomeMenumPage(),
    );
  }
}

/**
 * 有状态StatefulWidget
 *  继承于 StatefulWidget，通过 State 的 build 方法去构建控件
 */
class BotomeMenumPage extends StatefulWidget {
  BotomeMenumPage();

  //主要是负责创建state
  @override
  BotomeMenumPageState createState() => BotomeMenumPageState();
}

/**
 * 在 State 中,可以动态改变数据
 * 在 setState 之后，改变的数据会触发 Widget 重新构建刷新
 */
class BotomeMenumPageState extends State<BotomeMenumPage> {
  BotomeMenumPageState();

  String debugLable = 'Unknown';

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    initPlatformState();

    Init().init(this.context);

    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      jpush.addEventHandler(onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
        setState(() {
          debugLable = "flutter onReceiveNotification: $message";
        });
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        setState(() {
          debugLable = "flutter onOpenNotification: $message";
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        setState(() {
          debugLable = "flutter onReceiveMessage: $message";
        });
      }, onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        setState(() {
          debugLable = "flutter onReceiveNotificationAuthorization: $message";
        });
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jpush.setup(
      appKey: "f7ec188c8df31cdca3d50b22", //你自己应用的 AppKey
      channel: "developer-default",
      production: true,
      debug: true,
    );
    jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    //构建页面
    return buildBottomTabScaffold();
  }

  //当前显示页面的
  int currentIndex = 0;

  //底部导航栏显示的内容
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.android_rounded),
      title: Text("机器人控制"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[600],
      icon: Icon(Icons.desktop_windows),
      title: Text("群管理"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[800],
      icon: Icon(Icons.camera),
      title: Text("发现"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[900],
      icon: Icon(Icons.person),
      title: Text("我的"),
    ),
  ];

  //点击导航项是要显示的页面
  final pages = [Index1("机器人列表"), Index2("群列表"), Index3("发现"), Index4("我的")];

  Widget buildBottomTabScaffold() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: (index) {
          _changePage(index);
        },
      ),
      //对应的页面
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
