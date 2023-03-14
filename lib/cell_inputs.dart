import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/common.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';
import 'package:machsite/providers/firestore.dart';

import 'cell_editor.dart';
import 'cell_input.dart';

class CellInputs extends ConsumerWidget {
  final DS execCell;
  CellInputs(this.execCell, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (execCell.data() == null || execCell.data()!['inputs'] == null)
      return Container();
    return Column(
        children: execCell
            .data()!['inputs']
            .map<Widget>((e) => e == 'init'
                ? Container()
                : CellInput(DB.doc(execCell.reference.parent.parent!
                    .collection('input')
                    .doc(e)
                    .path)))
            .toList());
  }
}
