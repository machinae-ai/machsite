import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';

class ExecCell extends ConsumerWidget {
  final DocumentReference execCell;
  ExecCell(this.execCell, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(execCell.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (data) => Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Text(data.data()!['name'])),
                Flexible(child: Text(data.data()!['prompt'] ?? '')),
                Flexible(child: Text(data.data()!['code'] ?? '')),
                SizedBox(
                    width: 100,
                    height: 25,
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Prompt',
                                  ),
                                  onSubmitted: (v) {
                                    data.reference.set(
                                        {'prompt': v}, SetOptions(merge: true));
                                  }))
                        ]))
              ],
            )));
  }
}
