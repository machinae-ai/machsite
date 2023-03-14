import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/input.dart';
import 'package:machsite/providers/firestore.dart';

import 'common.dart';

class Inputs extends ConsumerWidget {
  final DR docRef;
  const Inputs(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(colSP(docRef.collection('input').path)).when(
            data: (inputDoc) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children:
                  inputDoc.docs.map((doc) => Input(doc.reference)).toList(),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text(e.toString()),
          );
}
