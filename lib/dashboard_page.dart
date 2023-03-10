import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/app_bar.dart';
import 'package:machsite/common.dart';
import 'package:machsite/run_bar.dart';
import 'package:machsite/run_log.dart';
import 'package:machsite/state/generic_state_notifier.dart';
import 'package:machsite/drawer.dart';
import 'package:http/http.dart' as http;
import 'exec_cells.dart';
import 'exec_rows.dart';
import 'inputs.dart';

final activeRun = StateNotifierProvider<GenericStateNotifier<String?>, String?>(
    (ref) => GenericStateNotifier<String?>(null));

class DashboardPage extends ConsumerWidget {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: MyAppBar.getBar(context, ref),
        drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
            ? TheDrawer.buildDrawer(context)
            : null,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: RunBar(kDB.doc('project/1'))),
                  Flexible(child: RunLog(kDB.doc('project/1'))),
                  Flexible(child: Inputs(kDB.doc('project/1'))),
                  Flexible(child: ExecCells(kDB.doc('project/1'))),
                  // Flexible(child: AddExecRow()),
                ],
              )),
        ));
  }
}
