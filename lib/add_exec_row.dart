import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddExecRow extends StatelessWidget {
  const AddExecRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var vac =
                  await FirebaseFirestore.instance.collection('execRow').add({
                'name': 'test',
                'timeCreated': FieldValue.serverTimestamp(),
                'desc': 'test',
              });
            })
      ],
    );
  }
}
