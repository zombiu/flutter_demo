import 'package:flutter/material.dart';

class AnimatedTranslateBox extends StatefulWidget {
  AnimatedTranslateBox({
    Key key,
    this.dx,
    this.dy,
    this.child,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
  });

  final double dx;
  final double dy;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  createState() => _AnimatedTranslateBoxState();
}

///一般情况下，就是通过CurvedAnimation或者Tween给AnimationController添加各种效果
///在这个底部弹出的动画里，通过曲线动画给AnimationController添加了动画曲线，通过补间动画修改了动画的范围区间
class _AnimatedTranslateBoxState extends State<AnimatedTranslateBox>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Tween<double> tween;

  void _updateCurve() {
    ///CurvedAnimation也是Animation的一个实现类，它的目的是为了给AnimationController增加动画曲线
    ///CurvedAnimation可以将AnimationController和Curve结合起来，生成一个新的Animation对象
    animation = widget.curve == null
        ? controller
        : CurvedAnimation(parent: controller, curve: widget.curve);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    ///创建Tween动画
    // Tween设置动画的区间值，animate()方法传入一个Animation，AnimationController继承Animation
    ///默认情况下，AnimationController动画生成的值所在区间是0.0到1.0
    /// 如果希望使用这个以外的值，或者其他的数据类型，就需要使用Tween
    tween = Tween<double>(begin: widget.dx ?? widget.dy);
    print("-->>开始 ${tween.begin} 结束 ${tween.end}");
    _updateCurve();
  }

  @override
  void didUpdateWidget(AnimatedTranslateBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行了didUpdateWidget ${widget.dy} ${tween.begin} ${tween.evaluate(animation)}");
    //如果改变了曲线动画
    if (widget.curve != oldWidget.curve) _updateCurve();
    //更新动画控制器信息
    controller
      ..duration = widget.duration
      ..reverseDuration = widget.reverseDuration;
    //弹出底部dialog时，dy=0，
    if ((widget.dx ?? widget.dy) != (tween.end ?? tween.begin)) {
      tween
        ..begin = tween.evaluate(animation)
        ..end = widget.dx ?? widget.dy;
      //重置动画初始化值，并启动动画
      controller
        ..value = 0.0
        ..forward();
      print("开始执行动画");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  build(context) => AnimatedBuilder(
        animation: animation,

        ///Transform.translate接收一个offset参数，可以在绘制时沿x、y轴对子组件平移指定的距离。
        ///默认原点为左上角，向右、向下，数值为正，向左、向上，数值为负
        ///每次更新动画时，都会回调builder方法
        builder: (context, child) => widget.dx == null
            ? Transform.translate(
          ///animate()方法传入一个Animation，当前动画的值
                offset: Offset(0, tween.animate(animation).value),
                child: child,
              )
            : Transform.translate(
                offset: Offset(tween.animate(animation).value, 0),
                child: child,
              ),
        child: widget.child,
      );
}
