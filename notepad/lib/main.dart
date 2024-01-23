import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/homePageState.dart';

void main() async {
  //init hive
  await Hive.initFlutter();
  //ouvrir une boîte
  var box = await Hive.openBox("mybox");

  runApp(const TODONOTE());
}

class TODONOTE extends StatelessWidget {
  const TODONOTE({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
}
