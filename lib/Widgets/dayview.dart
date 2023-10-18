import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  final EventController controller;
  final CalendarEventData event;
  const Day({super.key , required this.controller, required this.event});

  @override
  State<Day> createState() => _DayviewState();
}

class _DayviewState extends State<Day> {

  @override
  Widget build(BuildContext context) {

    return DayView(controller: widget.controller ,onDateLongPress: (date)=>{widget.controller.add(widget.event)});
  }
}
