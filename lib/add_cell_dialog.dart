import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'common.dart';

showAddCellDialog(BuildContext context, CR colRef) {
  showDialog(
      context: context,
      builder: (context) {
        final _addCellController = TextEditingController();
        String type = 'python';
        return AlertDialog(
            title: Text('Add Cell'),
            content: Column(
              children: [
                TextField(
                  controller: _addCellController,
                  decoration: InputDecoration(hintText: 'Cell Name'),
                ),
                DropdownButton<String>(
                    value: type,
                    items: [
                      DropdownMenuItem(
                          child: Text('Python Exec'), value: 'python'),
                      DropdownMenuItem(
                          child: Text('Python Eval'), value: 'eval'),
                      DropdownMenuItem(
                          child: Text('GPT Code'), value: 'gpt_code'),
                      DropdownMenuItem(
                          child: Text('GPT Text'), value: 'gpt_text'),
                      DropdownMenuItem(
                          child: Text('Get Page'), value: 'get_page')
                    ],
                    onChanged: (v) {
                      type = v ?? 'python';
                    }),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    colRef.add({
                      'name': _addCellController.text,
                      'type': type,
                      'timeCreated': FieldValue.serverTimestamp(),
                      'inputs': ['init'],
                      
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'))
            ]);
      });
}
