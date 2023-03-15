import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:providers/firestore.dart';

import 'common.dart';
import 'dashboard_page.dart';

class SetOutputWidget extends ConsumerWidget {
  final DR docRef;
  const SetOutputWidget(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      Text('Set output'),
      Row(
          children: ref
              .watch(colSP(docRef.parent.parent!.collection('input').path))
              .when(
                  loading: () => [Container()],
                  error: (e, s) => [ErrorWidget(e)],
                  data: (data) => data.docs
                      .map((e) => GestureDetector(
                          onTap: () => {
                                docRef.update({'output': e.id}),
                              },
                          child: Chip(label: Text(e.data()['name']))))
                      .toList())),
    ]);
  }
}
