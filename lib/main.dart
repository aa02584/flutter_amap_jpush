import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '高德地图Flutter测试',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: '高德地图Flutter测试'),
      home: JpushTest("极光推送Flutter测试"),
    );
  }
}


// 极光推送Flutter测试
class JpushTest extends StatefulWidget {
  String title;

  JpushTest(this.title);

  @override
  _JpushTestState createState() => _JpushTestState();
}

class _JpushTestState extends State<JpushTest> {
  String debugLable = "Unknown";
  final JPush jPush = JPush();

  Future<void> initJpushState() async {
    String platformVersion;
    try {
      jPush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("》》》》》》》》》接受到推送了信息为：$message");
          setState(() {
            debugLable = "接受到推送$message";
          });
        },
      );
    } on PlatformException {
      platformVersion = "平台版本获取失败，请检查！";
    }

    if (!mounted) {
      setState(() {
        debugLable = platformVersion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          children: [
            new Text('结果: $debugLable\n'),
            new FlatButton(
                child: new Text('发送推送消息\n'),
                onPressed: () {
                  // 三秒后出发本地推送
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch + 3000);
                  var localNotification = LocalNotification(
                    id: 234,
                    title: '测试标题',
                    buildId: 1,
                    content: '看到了说明已经成功了',
                    fireTime: fireDate,
                    subtitle: '一个测试',
                  );
                  jPush.sendLocalNotification(localNotification).then((res) {
                    setState(() {
                      debugLable = res;
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }
}


// 高德地图Flutter测试
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
        },
        amapOptions: AMapOptions(
          compassEnabled: false,
          zoomControlsEnabled: true,
          logoPosition: LOGO_POSITION_BOTTOM_CENTER,
          camera: CameraPosition(
            target: LatLng(41.851827, 112.801637),
            zoom: 4,
          ),
        ),
      ),
    );
  }
}
