import 'package:auth/current_user_avatar_extended.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machsite/common.dart';
import 'package:machsite/main.dart';
import 'package:machsite/state/theme_state_notifier.dart';
import 'package:machsite/user_profile.dart';

class MyAppBar {
  static final List<String> _tabs = [
    'dashboard',
    'other',
  ];

  static PreferredSizeWidget getBar(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      // backgroundColor: Colors.white,
      // automaticallyImplyLeading:
      //     (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
      //         ? true
      //         : false,
      leadingWidth:
          (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH) ? null : 100,
      // leading: Builder(
      //   builder: (BuildContext context) {
      //     return (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
      //         ? IconButton(
      //             icon: SvgPicture.asset(
      //                 isDarkMode ? 'assets/dark.svg' : 'assets/light.svg'),
      //             onPressed: () {
      //               Scaffold.of(context).openDrawer();
      //             },
      //             tooltip:
      //                 MaterialLocalizations.of(context).openAppDrawerTooltip,
      //           )
      //         : Padding(
      //             padding: EdgeInsets.all(10),
      //             child: SvgPicture.asset(
      //                 isDarkMode ? 'assets/dark.svg' : 'assets/light.svg'),
      //           );
      //   },
      // ),
      title: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
          ? null
          : Align(
              alignment: AlignmentDirectional.topStart,
              child: SizedBox(
                  width: 800,
                  child: TabBar(
                    tabs: _tabs
                        .map((t) => Tab(
                            iconMargin: EdgeInsets.all(0),
                            child:
                                // GestureDetector(
                                //     behavior: HitTestBehavior.translucent,
                                //onTap: () => navigatePage(text, context),
                                //child:
                                Text(t.toUpperCase(),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(
                                        color:
                                            // Theme.of(context).brightness == Brightness.light
                                            //     ? Color(DARK_GREY)
                                            //:
                                            Colors.white))))
                        .toList(),
                    onTap: (index) {
                      Navigator.of(context).pushNamed(_tabs[index]);
                    },
                  ))),
      actions: [
        ThemeIconButton(),
        IconButton(
            onPressed: () {
              ref.read(isLoggedIn.notifier).value = false;
              FirebaseAuth.instance.signOut();
              // print("Signed out");
            },
            icon: Icon(Icons.exit_to_app)),
        //CurrentUserAvatar()
        CurrentUserAvatarExtended(child: UserProfileDetails())
      ],
    );
  }
}

class ThemeIconButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkState = ref.watch(themeStateNotifierProvider);
    return IconButton(
        tooltip: 'dark/light mode',
        onPressed: () {
          ref.read(themeStateNotifierProvider.notifier).changeTheme();
        },
        icon: Icon(isDarkState == true
            ? Icons.nightlight
            : Icons.nightlight_outlined));
  }
}
