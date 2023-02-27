import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/cell_inputs.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';

import 'cell_output.dart';

class CellEditor extends ConsumerWidget {
  final DocumentReference<Map<String, dynamic>> docRef;

  CellEditor(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      DocFieldTextEdit2(docRef, 'name',
          decoration: InputDecoration(label: Text('Cell Name'))),
      CellInputs(docRef),
      DocMultilineTextField(docRef, 'prompt', 5),
      DocMultilineTextField(docRef, 'code', 10),
      ElevatedButton(onPressed: () {}, child: Text('Run')),
      CellOutput(docRef)
    ]);
  }
}
