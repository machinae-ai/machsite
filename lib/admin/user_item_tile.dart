import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/admin/user_details.dart';
import 'package:machsite/admin/user_details_page.dart';
import 'package:machsite/dashboard_page.dart';
import 'package:providers/firestore.dart';

import '../admin_viewpage.dart';
import '../controls/doc_field_text_edit.dart';

class UserItemTile extends ConsumerWidget {
  final DocumentReference userDocRef;
  // const SearchListItem(this.searchRef);
  final TextEditingController ctrl = TextEditingController();

  UserItemTile(this.userDocRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(userDocRef.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (searchDoc) => Card(
                child: Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            (searchDoc.id),
                            //style: Theme.of(context).textTheme.headline3,
                          )),
                      // Flexible(
                      //     flex: 1,
                      //     child:
                      //         //Text(searchDoc.data()!['name'].toString() ?? '')),
                      //         Text(searchDoc.id)),
                    ],
                  ),
                  onTap: () {
                    //ref.read(activeUser.notifier).value = searchRef.id;
                    print('named push');
                    Navigator.pushNamed(
                      context,
                      UserDetailsPage.routeName,
                      arguments: PageArguments(
                        searchDoc.id,
                        'This message is extracted in the build method.',
                      ),
                    );
                    // Navigator.of(context).pushNamed('user',

                    // ); //searchRef.id);
                  },
                )
              ],
            )));
  }
}
