import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';

class CellOutput extends ConsumerWidget {
  final DocumentReference<Map<String, dynamic>> docRef;

  CellOutput(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(docSP(docRef.path)).when(
          loading: () => Container(),
          error: (e, s) => ErrorWidget(e),
          data: (data) => Container(
              padding: EdgeInsets.all(10),
              child: Expanded(
                  child: Row(children: [
                Text(data.data()?['output'] ?? 'No output'),
              ]))));
}
