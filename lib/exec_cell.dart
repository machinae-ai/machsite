import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/common.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';
import 'package:machsite/providers/firestore.dart';

import 'cell_editor.dart';
import 'cell_inputs.dart';
import 'exec_type.dart';

class ExecCell extends ConsumerWidget {
  final DocumentReference execCell;
  ExecCell(this.execCell, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(execCell.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (data) => Card(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildInputs(context, ref, data),
                    if (data.data()!['type'] == CellType.eval)
                      _buildEvalContent(context, ref, data),
                    if (data.data()!['type'] == CellType.gpt_code)
                      _buildGPTCodeContent(context, ref, data),

                    Flexible(child: Text(data.data()!['name'] ?? '')),
                    Flexible(child: Text(data.data()!['prompt'] ?? '')),
                    Flexible(child: Text(data.data()!['code'] ?? '')),
                    Flexible(
                        child: Row(children: [
                      Text('=>'),
                      Card(child: Text('${data.data()!['output'] ?? ''}'))
                    ])),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Edit"),
                                  content: CellEditor(data.reference),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.edit))

                    // SizedBox(
                    //     width: 200,
                    //     height: 100,
                    //     child: Row(
                    //         mainAxisSize: MainAxisSize.max,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //               child: TextField(
                    //                   maxLines: null,
                    //                   decoration: InputDecoration(
                    //                     border: OutlineInputBorder(),
                    //                     labelText: 'Prompt',
                    //                   ),
                    //                   onSubmitted: (v) {
                    //                     print(v);
                    //                     data.reference.set(
                    //                         {'prompt': v}, SetOptions(merge: true));
                    //                   }))
                    //         ]))
                  ],
                ))));
  }

  _buildEvalContent(BuildContext context, WidgetRef ref, DS data) {
    return Column(
      children: [Text(data['code'])],
    );
  }

  _buildGPTCodeContent(BuildContext context, WidgetRef ref,
      DocumentSnapshot<Map<String, dynamic>> data) {
    return Column(
      children: [Text(data['code'])],
    );
  }

  _buildInputs(BuildContext context, WidgetRef ref,
      DocumentSnapshot<Map<String, dynamic>> data) {
    return CellInputs(data);
  }
}
