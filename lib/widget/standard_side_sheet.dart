import 'package:flutter/material.dart';

const _kDefaultWidth = 400.0;
const _kDefaultThickness = 1.0;

class BodyWithSideSheet extends StatelessWidget {
  const BodyWithSideSheet({
    Key? key,
    this.show = false,
    required this.body,
    this.sheetWidth = _kDefaultWidth,
    required this.sheetBody,
  }) : super(key: key);

  /// App body referred as [Scaffold.body]
  final Widget body;

  final bool show;

  final double? sheetWidth;

  /// The body of the side sheet. Typically a [Widget].
  final Widget sheetBody;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: body),
        if (show)
          SizedBox(
            width: _kDefaultThickness,
            child: Center(
              child: Container(
                width: _kDefaultThickness,
                decoration: BoxDecoration(
                  border: Border(
                    left: Divider.createBorderSide(context,
                        color: Theme.of(context).dividerColor,
                        width: _kDefaultThickness),
                  ),
                ),
              ),
            ),
          ),
        _ShrinkableSize(
            show: show,
            child: SizedBox(
                width: sheetWidth,
                height: MediaQuery.of(context).size.height,
                child: sheetBody)),
      ],
    );
  }
}

class _ShrinkableSize extends StatefulWidget {
  const _ShrinkableSize({Key? key, required this.child, required this.show})
      : super(key: key);

  /// The child of the [_ShrinkableSize] widget.
  final Widget child;

  /// Whether to shrink or not.
  final bool show;

  @override
  __ShrinkableSizeState createState() => __ShrinkableSizeState();
}

class __ShrinkableSizeState extends State<_ShrinkableSize>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.show ? controller.forward() : controller.reverse();
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: widget.child,
    );
  }
}
