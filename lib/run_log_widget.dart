import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:machsite/providers/firestore.dart';

import 'common.dart';

class RunLogWidget extends ConsumerWidget {
  final DocumentReference docRef;

  RunLogWidget(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(colSP(docRef.collection('run').path)).when(
        data: (col) {
          if (col.docs.length == 0) {
            return Text('no run');
          }
          return Column(
              children: (col.docs
                    ..sort((a, b) => Jiffy(b.data()['timeCreated'].toDate())
                            .isBefore(Jiffy(a.data()['timeCreated'].toDate()))
                        ? 1
                        : -1))
                  .map((e) => Text(
                      '${e.data()?['name']} ${e.data()?['type']} ${Jiffy(e.data()['timeCreated'].toDate()).format(DATE_FORMAT)} ${e.data()?['error']} ${e.data()?['output']}'))
                  .toList());
          // Text(
          //     '${col.docs[0].data()?['name']} ${col.docs[0].data()?['type']} ${col.docs[0].data()?['timeCreated']} ${col.docs[0].data()?['error']} ${col.docs[0].data()?['output']}');
          //${col.docs[0].data()?['output']}');
        },
        loading: () => Text('loading'),
        error: (e, s) => Text('error $e'));
  }
}
