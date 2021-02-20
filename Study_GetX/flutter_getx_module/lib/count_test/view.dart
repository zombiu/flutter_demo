import 'package:flutter/material.dart';
import 'package:flutter_getx_module/animated_translate_box.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class CountTestPage extends StatelessWidget {
  final CountTestLogic logic = Get.put(CountTestLogic());
  final Duration bottomSheetDuration = Duration(milliseconds: 200);
  final double bottomSheetHeight = 200;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestModel(),
      child: Scaffold(
        appBar: AppBar(title: Text("测试"), actions: []),
        body: body,
        floatingActionButton: Builder(builder:(BuildContext context) {
          return FlatButton(
            child: Icon(Icons.add),
            onPressed: () {
              Provider.of<TestModel>(context).show();
            },
          );
        },),
      ),
    );
  }

  //如果不toDouble()，那么会报 type 'int' is not a subtype of type 'double'的错误
  get shareBottomSheetHeight => 200.toDouble();

  get body => Stack(
        children: <Widget>[
          Container(),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: bottomSheetBox,
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: shareBottomSheetHeight,
            child: bottomSheetBoxMask,
          ),
        ],
      );

  get bottomSheetBox => Selector<TestModel, bool>(
        selector: (context, model) => model.showBottomSheet,
        builder: (context, show, child) => AnimatedOpacity(
          opacity: show ? 1 : 0,
          curve: show ? Curves.easeOut : Curves.easeIn,
          duration: bottomSheetDuration,
          child: AnimatedTranslateBox(
            dy: show ? 0 : bottomSheetHeight,
            curve: show ? Curves.easeOut : Curves.easeIn,
            duration: bottomSheetDuration,
            child: child,
          ),
        ),
        child: Container(
          height: bottomSheetHeight,
          child: bottomSheet,
        ),
      );

  get bottomSheet => Container(
        color: Colors.blueAccent,
      );

  get bottomSheetBoxMask => Container(
        child: Builder(builder: (BuildContext context) {
          return Listener(behavior:HitTestBehavior.opaque,onPointerDown:(_){
            print("-->>点击了半透明背景！");
            Provider.of<TestModel>(context,listen: false).show();
          },);
        },),
        color: Colors.grey,
      );
}

class TestModel with ChangeNotifier {
  bool showBottomSheet = false;

  void show() {
    showBottomSheet = !showBottomSheet;
    notifyListeners();
  }
}
