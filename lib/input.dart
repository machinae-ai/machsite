import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';

import 'common.dart';

class Input extends ConsumerWidget {
  final DR docRef;
  const Input(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(docSP(docRef.path)).when(
          data: (doc) => Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(doc.id),
                  Text(doc.data()!['type'].toString())
                ]),
              )),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text(e.toString()));
}
