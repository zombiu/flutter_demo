import 'package:flutter/material.dart';
import 'package:flutter_getx_module/routes/app_pages.dart';
import 'package:get/get.dart';

class VideoConferenceHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('会议'),
        actions: [
          IconButton(
              icon: Text('设置'),
              onPressed: () {
                print("-->>跳转设置");
              })
        ],
      ),
      body: VideoConferenceBody(),
    );
  }
}

class VideoConferenceBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var widgets = buildGridItems();
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.builder(
              itemCount: widgets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  //这里会自己去按比例设置item宽高
                  childAspectRatio: 1.0),
              itemBuilder: (ctx, index) {
                return widgets[index];
              },
              shrinkWrap: true),
          MeetingListWidget(),
          Listener(
            child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200, 200)),
                child: Center(
                  child: Text('click me'),
                )),
            behavior: HitTestBehavior.translucent,//显性的修改behavior属性
            onPointerDown: (event) => print("onPointerDown"),
          )
        ]);
  }

  List<Widget> buildGridItems() {
    var widgets = [
      Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: GestureDetector(
          onTap: ()=> Get.toNamed(AppPages.PROVIDER),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.add,
              ),
              Text('即刻会议')
            ],
          ),
        ),
      ),
      SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.add,
            ),
            Text('加入会议')
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          print("-->>预约会议");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.add,
            ),
            Text('预约会议')
          ],
        ),
      ),
    ];
    return widgets;
  }
}

class MeetingListWidget extends StatefulWidget {
  @override
  _MeetingListWidgetState createState() => _MeetingListWidgetState();
}

class _MeetingListWidgetState extends State<MeetingListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.grey),
      child: Column(
        children: [Icon(Icons.add), Text('当前暂无即将召开的会议')],
      ),
    ));
  }
}
