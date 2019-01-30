import 'dart:async';

import 'package:flutter/material.dart';

class _CircularIndicator extends Center {
  _CircularIndicator(
      {double wh: 64.0,
      Color backgroundColor,
      Color valueColor,
      double strokeWidth: 8.0})
      : assert(backgroundColor != null),
        assert(valueColor != null),
        super(
          child: SizedBox(
            width: wh,
            height: wh,
            child: Container(
              padding: EdgeInsets.all(strokeWidth),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(
                  valueColor,
                ),
              ),
            ),
          ),
        );
}

typedef WaitingCallback = Future Function();

void showWaitingDialog(
    {@required BuildContext context,
    @required WaitingCallback onWaiting,
    Color backgroundColor,
    Color color,
    double strokeWidth: 8.0,
    VoidCallback onDone}) async {
  assert(context != null);
  assert(onWaiting != null);
  ThemeData theme = Theme.of(context);
  backgroundColor = backgroundColor ?? theme.dialogBackgroundColor;
  color = color ?? theme.primaryColor;
  var w = Waiting(
    backgroundColor: backgroundColor,
    color: color,
    strokeWidth: strokeWidth,
  );
  showDialog(context: context, builder: (_) => w);
  await onWaiting().then((_) {
    w.pop(context);
    if (onDone != null) onDone();
  });
}

class Waiting extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;

  Waiting({this.backgroundColor, this.color, this.strokeWidth});

  void pop(BuildContext context) => Navigator.of(context).pop();

  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final wh = (media.orientation == Orientation.portrait)
        ? media.size.width * .2
        : media.size.height * .2;
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        child: _CircularIndicator(
          wh: wh,
          backgroundColor: widget.backgroundColor,
          valueColor: widget.color,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}
