import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:machsite/exec_cell.dart';
import 'package:machsite/providers/firestore.dart';

import 'common.dart';
import 'exec_row.dart';

class ExecRows extends ConsumerWidget {
  final CollectionReference execRows = DB.collection("execRow");
  ExecRows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(colSP(execRows.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (data) =>
            // ListView(
            //     padding: EdgeInsets.zero,
            //     shrinkWrap: true,
            Column(
                children: (data.docs
                      ..sort((a, b) => Jiffy(a.data()['timeCreated'].toDate())
                              .isBefore(Jiffy(b.data()['timeCreated'].toDate()))
                          ? -1
                          : 1))
                    // a
                    //         .data()['timeCreated']
                    //         .compareTo(b.data()['timeCreated'])
                    .map((e) => ExecCells(e.reference))
                    .toList()));
  }
}
