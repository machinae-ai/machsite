import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common.dart';

class RunBar extends ConsumerWidget {
  final DR docRef;
  const RunBar(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          docRef.collection('run').add({
            'timestamp': FieldValue.serverTimestamp(),
          });
        },
        child: Text('Run'));
  }
}
