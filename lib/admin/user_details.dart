import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/providers/firestore.dart';
import 'package:machsite/state/generic_state_notifier.dart';

final activeUser =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class UserDetails extends ConsumerWidget {
  final String? entityId;

  final TextEditingController idCtrl = TextEditingController(),
      nameCtrl = TextEditingController(),
      descCtrl = TextEditingController();

  UserDetails(this.entityId);

  @override
  Widget build(BuildContext context, WidgetRef ref) => entityId == null
      ? Container()
      : ref.watch(docSP('user/${entityId!}')).when(
          loading: () => Container(),
          error: (e, s) => ErrorWidget(e),
          data: (userDoc) => Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Column(children: [
                Text(userDoc.id),
                Text('name: ${userDoc.data()!['name'] ?? ''}'),
                Text('email: ${userDoc.data()!['email'] ?? ''}'),
              ])));
}
