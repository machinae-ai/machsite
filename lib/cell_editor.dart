import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';
import 'package:machsite/inputs_editor.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';
import 'package:machsite/providers/firestore.dart';
import 'package:machsite/run_log_widget.dart';

import 'cell_output.dart';
import 'common.dart';
import 'exec_type.dart';

class CellEditor extends ConsumerWidget {
  final DocumentReference<Map<String, dynamic>> docRef;

  CellEditor(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      // ref.watch(docFP(docRef.path)).when(
      //     data: (data) => Text(
      //         """id: ${docRef.id}, type: ${getCellTypeByString(data.data()!['type'])}, type_name:
      //         ${CellTypeExt(getCellTypeByString(data.data()!['type'])).info.name}"""),
      //     loading: () => Text('loading'),
      //     error: (e, s) => Text('error $e')),

      DocFieldTextEdit2(docRef, 'name',
          decoration: InputDecoration(label: Text('Cell Name'))),
      InputsEditor(docRef),
      DocMultilineTextField(docRef, 'prompt', 5),
      ElevatedButton(
          onPressed: () async {
            docRef.get().then((doc) async {
              print(doc.data());
              if (doc.data()?['prompt'] != null) {
                final userId = kUSR!.uid;
                print(
                    'generate code for ${doc.data()?['prompt']}, uid: ${userId}');

                kDB.doc('user/${userId}').get().then((userDoc) async {
                  final Response response = await http.post(
                      Uri.parse('https://api.openai.com/v1/completions'),
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':
                            'Bearer ${userDoc.data()?['openai_key']}'
                      },
                      body: jsonEncode({
                        //'model': 'text-davinci-003',
                        'model': 'code-davinci-002',
                        'prompt': '${doc.data()?['prompt']}',
                        //'"""\n${doc.data()?['prompt']}\n"""',
                        'max_tokens': 50,
                        'temperature': 0,
                        'top_p': 1,
                        'frequency_penalty': 0,
                        'presence_penalty': 0,
                        // 'stop': ["###"],
                        //'n': 1,
                        //'stop': '\n'
                      }));

                  if (response.statusCode == 200) {
                    print(jsonDecode(response.body));
                    docRef.update({
                      'code': jsonDecode(response.body)['choices'][0]['text']
                    });
                  } else {
                    print(
                        'Request failed with status: ${response.statusCode} ${response.body}.');
                  }
                });
              }
            });
          },
          child: Text('Generate code')),
      DocMultilineTextField(docRef, 'code', 10),
      ElevatedButton(
          onPressed: () {
            docRef.get().then((doc) {
              print(doc.data());
              if (doc.data()?['code'] == null) {
                print('no code to run');
                return;
              }
              print('execute ${doc.data()?['code']}');
              docRef.collection('run').add({
                'name': 'output',
                'type': doc.data()!['type'],
                'code': doc.data()!['code'],
                'timeCreated': FieldValue.serverTimestamp(),
              });
            });
          },
          child: Text('Run')),
      RunLogWidget(docRef),
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

            docRef.delete();
          },
          child: Text('Delete')),

      // ref.watch(docSP(docRef.path)).when(
      //     data: (doc) {
      //       if (doc.data()?['error'] == null) {
      //         return Text('no run');
      //       }
      //       return Text('run ${doc.data()?['error']}');
      //     },
      //     loading: () => Text('loading'),
      //     error: (e, s) => Text('error $e')),

      //CellOutput(docRef)
    ]);
  }
}
