// ignore_for_file: unnecessary_string_escapes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mi_calculator/screens/calculator.dart';

// ignore: camel_case_types
class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

// ignore: camel_case_types
class _welcomeState extends State<welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Calculator())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              child: Column(children: [
                const Text(
                  'Welcome to my App',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/images/dart.png",
                      height: 150,
                    )),
              ]),
            ),
          ],
        )),
      ),
    );
  }
}
