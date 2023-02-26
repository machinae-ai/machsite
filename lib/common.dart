import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

final DB = FirebaseFirestore.instance;
final AUTH = FirebaseAuth.instance;
const DATE_FORMAT = 'yyyy-MM-dd';

List<Jiffy> generateWeeks(Jiffy start, Jiffy end) {
  List<Jiffy> list = [];
  Jiffy current = start;
  for (var i = 0; i < 1000; i++) {
    if (current.isAfter(end)) {
      break;
    }
    list.add(current);
    current = Jiffy(Jiffy(current).add(days: 8)).startOf(Units.WEEK);
  }
  return list;
}

List<Jiffy> generateMonths(Jiffy start, Jiffy end) {
  List<Jiffy> list = [];
  Jiffy current = Jiffy(start).startOf(Units.MONTH);
  for (var i = 0; i < 1000; i++) {
    if (current.isAfter(end)) {
      break;
    }
    list.add(current);
    current = Jiffy(current).add(days: 32).startOf(Units.MONTH);
  }
  return list;
}

List<Jiffy> generateDays(Jiffy start, Jiffy end) {
  List<Jiffy> list = [];
  Jiffy current = start;
  for (var i = 0; i < 1000; i++) {
    if (current.isAfter(end)) {
      break;
    }
    list.add(current);
    current = Jiffy(current).add(days: 1).startOf(Units.DAY);
  }
  return list;
}

const WIDE_SCREEN_WIDTH = 600;

const NUM_CELLS = 100;
const CELL_SIZE = 25.0;

String objectTypeByKey(String key) {
  switch (key) {
    case 'B':
      return 'button';
    case 'F':
      return 'frame';
    case 'C':
      return 'checkbox';
    case 'T':
      return 'text';
    case 'E':
      return 'textfield';
  }
  return 'unknown';
}

const CELL_BORDER_COLOR = Color.fromARGB(255, 70, 70, 70);

final cellBorder = BoxDecoration(
    border: Border(
  right: BorderSide(color: CELL_BORDER_COLOR, width: 0.3),
  left: BorderSide(color: CELL_BORDER_COLOR, width: 0.3),
  top: BorderSide(color: CELL_BORDER_COLOR, width: 0.3),
  bottom: BorderSide(color: CELL_BORDER_COLOR, width: 0.3),
));
