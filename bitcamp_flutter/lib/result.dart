import 'package:flutter/material.dart';

class ResultRoute extends StatelessWidget {
  String result;

  ResultRoute({super.key, required String this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}