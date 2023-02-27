import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunBar extends ConsumerWidget {
  const RunBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(onPressed: () {
      
    }, child: Text('Run'));
  }
}
