import 'package:flutter/material.dart';
import 'package:flutter_getx_module/message/native_message.dart';
import 'package:flutter_getx_module/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:nertc/nertc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
    ChannelManager.sendMessage({"method": "test2", "content": "flutter 中的数据", "code": 100});
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                constraints: BoxConstraints.tight(Size(300, 150)),
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

  void _videoConference() {
    Get.toNamed(AppPages.VIDEO_CONFERENCE_HOME);
  }
}
