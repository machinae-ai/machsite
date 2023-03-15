import 'dart:convert';

import 'package:common/common.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';
import 'package:machsite/inputs_editor.dart';
import 'package:machsite/controls/doc_field_text_edit.dart';
import 'package:machsite/controls/doc_multiline_text_field.dart';
import 'package:machsite/run_log_widget.dart';
import 'package:machsite/set_output_widget.dart';
import 'package:providers/firestore.dart';
import 'cell_output.dart';
import 'exec_type.dart';

class CellEditor extends ConsumerWidget {
  final DocumentReference<Map<String, dynamic>> docRef;

  CellEditor(this.docRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(docFP(docRef.path)).when(
          data: (data) {
            final cellType = getCellTypeByString(data.data()!['type']);
            return Column(children: [
              // Text(
              //     """id: ${docRef.id}, type: ${getCellTypeByString(data.data()!['type'])}, type_name:
              // ${CellTypeExt(getCellTypeByString(data.data()!['type'])).info.name}"""),
              DocFieldTextEdit2(docRef, 'name',
                  decoration: InputDecoration(label: Text('Cell Name'))),
              InputsEditor(docRef),
              if (cellType == CellType.get_page) _buildGetPageEditor(data),
              if (cellType == CellType.python) _buildCodeEditor(data),
              if (cellType == CellType.eval) _buildCodeEditor(data),
              if (cellType == CellType.gpt_code) _buildCodeEditor(data),
              if (cellType == CellType.gpt_text) _buildGPTTextEditor(data),
              SetOutputWidget(docRef),
              Divider(),
              _buildRunSection(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    docRef.delete();
                  },
                  child: Text('Delete')),
            ]);
          },
          loading: () => Text('loading'),
          error: (e, s) => Text('error $e'));

  _buildGetPageEditor(DocumentSnapshot<Map<String, dynamic>> data) {
    return DocFieldTextEdit2(docRef, 'url',
        decoration: InputDecoration(label: Text('URL to fetch')));
  }

  _buildCodeEditor(DocumentSnapshot<Map<String, dynamic>> data) {
    return Column(
      children: [
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
                          'max_tokens': 500,
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
      ],
    );
  }

  _buildPythonEditor(DocumentSnapshot<Map<String, dynamic>> data) {}

  _buildEvalEditor(DocumentSnapshot<Map<String, dynamic>> data) {}

  _buildGPTTextEditor(DocumentSnapshot<Map<String, dynamic>> data) {
    return Column(children: [
      DocMultilineTextField(docRef, 'prompt', 5),
    ]);
  }

  _buildRunSection() {
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            docRef.get().then((doc) {
              // if (doc.data()?['code'] == null) {
              //   print('no code to run');
              //   return;
              // }
              print('execute ${doc.data()?['code']}');
              docRef.collection('run').add({
                ...doc.data()!,
                'timeCreated': FieldValue.serverTimestamp(),
              });
            });
          },
          child: Text('Run')),
      RunLogWidget(docRef),
    ]);
  }
}
