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

class _AnimatedTranslateBoxState extends State<AnimatedTranslateBox>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  Tween<double> tween;

  void _updateCurve() {
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
    tween = Tween<double>(begin: widget.dx ?? widget.dy);
    _updateCurve();
  }

  @override
  void didUpdateWidget(AnimatedTranslateBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) _updateCurve();
    controller
      ..duration = widget.duration
      ..reverseDuration = widget.reverseDuration;
    if ((widget.dx ?? widget.dy) != (tween.end ?? tween.begin)) {
      tween
        ..begin = tween.evaluate(animation)
        ..end = widget.dx ?? widget.dy;
      controller
        ..value = 0.0
        ..forward();
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
    builder: (context, child) => widget.dx == null
        ? Transform.translate(
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
