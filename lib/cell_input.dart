import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/common.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';
import 'package:machsite/providers/firestore.dart';

import 'cell_editor.dart';

class CellInput extends ConsumerWidget {
  final DR inputRef;
  CellInput(this.inputRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(inputRef.path)).when(
          data: (inputDoc) => Text(inputDoc.data()!['name'].toString()),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text(e.toString()),
        );
  }
}
