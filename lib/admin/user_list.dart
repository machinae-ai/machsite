import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/admin/user_item_tile.dart';
import 'package:machsite/providers/firestore.dart';
import 'package:machsite/state/generic_state_notifier.dart';

final sortStateNotifierProvider =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class UserList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: ref.watch(colSP('user')).when(
          loading: () => [Container()],
          error: (e, s) => [ErrorWidget(e)],
          data: (data) => data.docs
              .map((e) => UserItemTile(key: Key(e.id), e.reference))
              .toList()));
}
