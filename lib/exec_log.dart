import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:providers/firestore.dart';

import 'common.dart';
import 'dashboard_page.dart';

class ExecLog extends ConsumerWidget {
  final DR docRef;
  const ExecLog(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(docSP(docRef.parent.parent!
            .collection('run')
            .doc(ref.watch(activeRun))
            .collection('run')
            .doc(docRef.id)
            .path))
        .when(
          data: (runDoc) {
            return Text(formatFirestoreDoc(runDoc));
          },
          loading: () => Container(),
          error: (e, s) => Text(e.toString()),
        );
  }
}
