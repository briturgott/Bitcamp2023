import 'package:bitcamp_flutter/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart';


void main() {
  runApp(const MaterialApp(
    title: 'Bitcamp',
    home: StartRoute(title: 'BitCamp',),
  ));
}

class StartRoute extends StatefulWidget {
  final String title;

  const StartRoute({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _StartRouteState createState() => _StartRouteState();
}

class _StartRouteState extends State<StartRoute>{
  late DropzoneViewController controller1;
  String message1 = 'Drop something here';
  bool highlighted1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to [NAME]'),
      ),
      body: Column(
        children: [
          Expanded(
                child: Container(
                  color: highlighted1 ? Colors.red : Colors.transparent,
                  child: Stack(
                    children: [
                      buildZone1(context),
                      Center(child: Text(message1)),
                    ],
                  ),
                ),
              ),
          ElevatedButton(
            child: const Text('Analyze File'),
            onPressed: () async {

              var string_data = await getData('http://127.0.0.1:5000/analyze');
              // var decodedData = jsonDecode(data);
              // print("hello");
              // print(decodedData);
              print(string_data);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoRoute(data: string_data)),
              );
          },
        ),
        ]
      ),
    );
  }
  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDrop: (ev) async {
            print('Zone 1 drop: ${ev.name}');
            setState(() {
              message1 = '${ev.name} dropped';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(ev);
            var md5_hash = md5.convert(bytes);
            print("Digest as hex string: $md5_hash");
            // print(bytes.sublist(0, 20));

          },
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      );
}


Future getData(url) async {
  var response = await post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"file_hash":"c8994e2703410f8dfe19de5bf82994c0"})
  );
  
  return response.body;
}