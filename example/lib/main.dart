import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ios_keychain/ios_keychain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _savedValue = "";
  String _savedKey = "dateTimeNow";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IOSKeychain'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Saved Value: $_savedValue"),
              TextButton(
                  child: Text("Return Saved Value"),
                  onPressed: () async {
                    String s = await IOSKeychain.read(_savedKey);
                    setState(() {
                      _savedValue = s;
                    });
                  }),
              TextButton(
                  child: Text("Save Current Time"),
                  onPressed: () async {
                    final now = DateTime.now();

                    bool s = await IOSKeychain.write(_savedKey, [now.hour, now.minute, now.second].join(":"));
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(s ? "Was saved" : "Not saved"),
                            ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
