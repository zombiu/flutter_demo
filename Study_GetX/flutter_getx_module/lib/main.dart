import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_getx_module/message/native_message.dart';
import 'package:flutter_getx_module/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:native_call/native_call.dart';
import 'package:nertc/nertc.dart';
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var defaultRouteName = window.defaultRouteName;
    print("-->>获取的路由 $defaultRouteName");
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppPages.INITIAL,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      getPages: AppPages.pages,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // ChannelManager.sendMessage({"method": "test", "content": "flutter 中的数据", "code": 100});
    ChannelManager.sendMessage(
        {"method": "test2", "content": "flutter 中的数据", "code": 100});
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    //注册flutter native 通信监听
    ChannelManager.receiveMessage();
    super.initState();
    getInfo();

    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    // 初始化
    ScreenUtil.init(
      // 设备像素大小(必须在首页中获取)
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      // 设计尺寸
      designSize: Size(375, 811),
      allowFontScaling: false,
    );
    ChannelManager.receiveMessage();
    // NERtcOptions()
    // ChannelManager.sendMessage({"method": "test2", "content": "flutter 中的数据", "code": 101});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _videoConference,
              child: Text(
                '视频会议',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            GestureDetector(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.w, 150.w)),
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('click me'),
                  ),
                ),
              ),
              onTapDown: (TapDownDetails details) {
                print("onTap down");
              },
              onTapUp: (TapUpDetails details) {
                print("onTap up");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeDependencies() {
    print("-->>调用了 didChangeDependencies()");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    print("-->>调用了 didUpdateWidget()");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("-->>调用了 deactivate()");
    super.deactivate();
  }

  @override
  void dispose() {
    print("-->>调用了 dispose()");
    super.dispose();
  }

  void getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionText = packageInfo.version;
    print("获取的版本是 $versionText");
  }

  void _videoConference() {
    Get.toNamed(AppPages.VIDEO_CONFERENCE_HOME);
  }

  void getVersion() async{
    String code = await NativeCall.platformVersion;
    print("-->>获取的android版本 ${code}");
  }
}
