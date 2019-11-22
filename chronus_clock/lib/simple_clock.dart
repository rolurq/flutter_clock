import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

/// Simple clock that just shows a text with the current time
class SimpleClock extends StatefulWidget {
  final ClockModel model;

  const SimpleClock(this.model);

  @override
  _SimpleClockState createState() => _SimpleClockState();
}

class _SimpleClockState extends State<SimpleClock> {
  DateTime _now = DateTime.now();
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat(widget.model.is24HourFormat ? 'HH:mm' : 'hh:mm')
        .format(_now);
    final textStyle = TextStyle(fontSize: 30);

    return Center(
      child: Text(
        time,
        style: textStyle,
      ),
    );
  }

  @override
  void didUpdateWidget(SimpleClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model
      ..removeListener(_updateModel)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  void _updateModel() {
    setState(() {
      // the model has already been updated, just trigger the widget update
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // schedule an update for the current time after one minute, discarding
      // the time that has already passed
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _now.second, milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }
}
