import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_module/animated_translate_box.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class CountTestPage extends StatelessWidget {
  final CountTestLogic logic = Get.put(CountTestLogic());
  final Duration bottomSheetDuration = const Duration(milliseconds: 2500);
  final double bottomSheetHeight = 200;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestModel(),
      child: BaseScaffold(
        appBar: AppBar(title: Text("测试"), actions: []),
        body: body,
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Provider.of<TestModel>(context, listen: false).show();
              },
            );
          },
        ),
      ),
    );
  }

  //如果不toDouble()，那么会报 type 'int' is not a subtype of type 'double'的错误
  get shareBottomSheetHeight => 200.toDouble();

  ///内容
  ///Positioned,只能在Stack 的childs中使用。 left、right、bottom、top分别表示 距离stack的边的距离,
  ///width、height表示宽高。Widget在指定left与width后，就自动确定了right。如果在设置right，则报错。其他情况（指定top与height，不能再指定bottom等）类似。
  get body => Stack(
        children: <Widget>[
          Container(
            color: Colors.brown,
          ),
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

  /// AnimatedOpacity 实现透明度渐变效果
  /// AnimatedTranslateBox 实现平移动画
  get bottomSheetBox => Selector<TestModel, bool>(
        selector: (context, model) => model.showBottomSheet,
        builder: (context, show, child) {
          print("-->>Selector ${show} ${child.runtimeType}");
          return AnimatedOpacity(
            opacity: show ? 1 : 0,
            curve: show ? Curves.easeOut : Curves.easeIn,
            duration: bottomSheetDuration,
            ///往底部偏移的距离为bottomSheetHeight
            child: AnimatedTranslateBox(
              dy: show ? 0 : bottomSheetHeight,
              curve: show ? Curves.easeOut : Curves.easeIn,
              duration: bottomSheetDuration,
              ///这里的child，就是下面的 Container
              child: child,
            ),
          );
        },
        child: Container(
          height: bottomSheetHeight,
          child: bottomSheet,
        ),
      );

  get bottomSheet => Container(
        color: Colors.blueAccent,
        child: Listener(
          behavior:HitTestBehavior.opaque ,
          onPointerDown: (PointerDownEvent event){
            print("-->>点击了dialogis");
          },
        ),
      );

  get bottomSheetBoxMask => Container(
        child: Builder(
          builder: (BuildContext context) {
            return Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) {
                print("-->>点击了半透明背景！");
                // Provider.of<TestModel>(context, listen: false).show();
                SmartDialog.show(
                  alignmentTemp: Alignment.bottomCenter,
                  clickBgDismissTemp: true,
                  onDismiss: () {
                    print('==============test callback==============');
                  },
                  widget: _contentWidget(maxHeight: 400),
                );
              },
            );
          },
        ),
        // color: Colors.grey,
        // decoration: BoxDecoration(color: Color(0x90000000)),
      );

  Widget _contentWidget({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)
        ],
      ),
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              //内容
              ListTile(
                leading: Icon(Icons.bubble_chart),
                title: Text('标题---------------$index'),
              ),

              //分割线
              Container(height: 1, color: Colors.black.withOpacity(0.1)),
            ],
          );
        },
      ),
    );
  }
}

class TestModel with ChangeNotifier {
  bool showBottomSheet = false;

  void show() {
    showBottomSheet = !showBottomSheet;
    notifyListeners();
  }
}

typedef ScaffoldParamVoidCallback = void Function();

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomPadding,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.isTwiceBack = false,
    this.isCanBack = true,
    this.onBack,
  })  : assert(primary != null),
        assert(extendBody != null),
        assert(extendBodyBehindAppBar != null),
        assert(drawerDragStartBehavior != null),
        super(key: key);

  ///系统Scaffold的属性
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Color drawerScrimColor;
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final bool resizeToAvoidBottomPadding;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;

  ///增加的属性
  ///点击返回按钮提示是否退出页面,快速点击俩次才会退出页面
  final bool isTwiceBack;

  ///是否可以返回
  final bool isCanBack;

  ///监听返回事件
  final ScaffoldParamVoidCallback onBack;

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: widget.appBar,
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerScrimColor: widget.drawerScrimColor,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      ),
      onWillPop: dealWillPop,
    );
  }

  ///控件返回按钮
  Future<bool> dealWillPop() async {
    if (widget.onBack != null) {
      widget.onBack();
    }

    //处理弹窗问题
    if (SmartDialog.instance.config.isExist) {
      SmartDialog.dismiss();
      return false;
    }

    //如果不能返回，后面的逻辑就不走了
    if (!widget.isCanBack) {
      return false;
    }

    if (widget.isTwiceBack) {
      if (_lastPressedAt == null ||
          DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
        //两次点击间隔超过1秒则重新计时
        _lastPressedAt = DateTime.now();

        //弹窗提示
        SmartDialog.showToast("再点一次退出");
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

  ///一些周期生命周期
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
