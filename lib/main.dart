import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/cell_editor.dart';
import 'package:machsite/choose_userview.dart';
import 'package:machsite/login_page.dart';
import 'package:machsite/state/generic_state_notifier.dart';
import 'package:machsite/state/theme_state_notifier.dart';
import 'package:machsite/theme.dart';
import 'package:sandbox/sandbox_launcher.dart';
import 'common.dart';
import 'firebase_options.dart';
import 'package:clipboard/clipboard.dart';

void main(List<String> args) async {
  print('args: $args');
  WidgetsFlutterBinding.ensureInitialized();

  // FlutterClipboard.paste().then((value) {
  //   print(value);
  // });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkTheme = ref.watch(themeStateNotifierProvider);
    return MaterialApp(
      title: 'AI MACHINAE',
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SandboxLauncher(
        app: TheApp(),
        sandbox: Scaffold(body: Container()
            // CellEditor(kDB.doc(
            //     '/execRow/8iklcwPZXjRy4EFblLPW/cell/f95PfS75PCfBBN9EWfaO'))
            ),
        getInitialState: () => kDB
            .doc('sandbox/serge')
            .get()
            .then((doc) => doc.data()!['sandbox']),
        saveState: (state) => {
          kDB.doc('sandbox/serge').set({'sandbox': state})
        },
      ),
    );
  }
}

final isLoggedIn = StateNotifierProvider<GenericStateNotifier<bool>, bool>(
    (ref) => GenericStateNotifier<bool>(false));

final isLoading = StateNotifierProvider<GenericStateNotifier<bool>, bool>(
    (ref) => GenericStateNotifier<bool>(false));

class TheApp extends ConsumerStatefulWidget {
  const TheApp({Key? key}) : super(key: key);
  @override
  TheAppState createState() => TheAppState();
}

class TheAppState extends ConsumerState<TheApp> {
  //bool isLoading = false;
  @override
  void initState() {
    super.initState();
    ref.read(isLoading.notifier).value = true;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        ref.read(isLoggedIn.notifier).value = false;
        ref.read(isLoading.notifier).value = false;
      } else {
        ref.read(isLoggedIn.notifier).value = true;
        ref.read(isLoading.notifier).value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(isLoading)) {
      return Center(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          body: ref.watch(isLoggedIn) == false
              ? LoginPage()
              : ChooseUserViewWidget());
    }
  }
}
