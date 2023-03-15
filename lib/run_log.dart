import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:providers/firestore.dart';

import 'common.dart';
import 'dashboard_page.dart';

class RunLog extends ConsumerWidget {
  final DR docRef;
  const RunLog(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(
            colSPfiltered(docRef.collection('run').path, orderBy: 'timestamp'))
        .when(
          data: (runDoc) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: runDoc.docs
                .map((doc) => Row(
                      children: [
                        doc.data()['timestamp'] == null
                            ? Container()
                            : Text(Jiffy(doc.data()['timestamp'].toDate())
                                .format()),
                        ElevatedButton(
                            onPressed: () =>
                                ref.read(activeRun.notifier).value = doc.id,
                            child: Text('View')),
                        ElevatedButton(
                            onPressed: () =>
                                doc.reference.delete().then((value) => {}),
                            child: Text('Delete'))
                      ],
                    ))
                .toList(),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text(e.toString()),
        );
  }
}
