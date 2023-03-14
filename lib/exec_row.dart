import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';

import 'add_cell_dialog.dart';
import 'exec_cell.dart';
import 'exec_log.dart';

class ExecCells extends ConsumerWidget {
  final DocumentReference execRow;
  ExecCells(this.execRow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(execRow.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (data) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Text(data.data()!['name']),
                  Flexible(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: ref
                              .watch(colSP(execRow.collection('cell').path))
                              .when(
                                  loading: () => [Container()],
                                  error: (e, s) => [ErrorWidget(e)],
                                  data: (data) => data.docs
                                      .map((e) => Flexible(
                                          child: 
                                          
                                          Row(
                                            children: [
                                              ExecCell(e.reference),
                                              ExecLog(e.reference)
                                            ],
                                          )
                                          
                                          ))
                                      .toList()))),
                  Flexible(
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => showAddCellDialog(
                              context, execRow.collection('cell')))),
                  // IconButton(
                  //     onPressed: () {
                  //       execRow.delete();
                  //     },
                  //     icon: Icon(Icons.delete))
                ]));
  }
}
