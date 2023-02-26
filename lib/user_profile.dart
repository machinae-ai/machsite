import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/common.dart';
import 'package:machsite/providers/firestore.dart';

class UserProfileDetails extends ConsumerWidget {
  const UserProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docFP('user/${AUTH.currentUser!.uid}')).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (data) => Row(children: [
              Flexible(child: Text('API Key:')),
              Flexible(
                  child: TextField(
                controller:
                    TextEditingController(text: data.data()?['apiKey'] ?? ''),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter API Key',
                ),
                onSubmitted: (v) {
                  DB
                      .doc('user/${AUTH.currentUser!.uid}')
                      .set({'apiKey': v}, SetOptions(merge: true));
                },
              )),
            ]));
  }
}
