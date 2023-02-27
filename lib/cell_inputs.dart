import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';

import 'controls/doc_field_text_edit.dart';
import 'controls/doc_multiline_text_field.dart';

class CellInputs extends ConsumerWidget {
  final DocumentReference<Map<String, dynamic>> cellDocRef;

  CellInputs(this.cellDocRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      Row(
          children: ref
              .watch(colSP(cellDocRef.parent.parent!.collection('cell').path))
              .when(
                  loading: () => [Container()],
                  error: (e, s) => [ErrorWidget(e)],
                  data: (data) => data.docs
                      .map((e) => GestureDetector(
                          onTap: () => {
                                cellDocRef.collection('input').doc(e.id).set({
                                  'name': e.data()['name'],
                                  'cell': e.reference
                                }),
                                print('added input')
                              },
                          child: Chip(label: Text(e.data()['name']))))
                      .toList())),
      Column(
          children: ref.watch(colSP(cellDocRef.collection('input').path)).when(
              loading: () => [Container()],
              error: (e, s) => [ErrorWidget(e)],
              data: (data) => data.docs
                  .map((e) => Row(
                        children: [
                          Chip(
                              label: Text(e.data()['name']),
                              deleteIcon: Icon(Icons.delete),
                              onDeleted: () => {e.reference.delete()}),
                          Expanded(
                              child:
                                  DocFieldTextEdit2(e.reference, 'mockValue')),
                        ],
                      ))
                  .toList())),
    ]);
  }
}
