import 'package:bitcamp_flutter/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:crypto/crypto.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:convert';
import 'package:http/http.dart';

String my_hash = "";

void main() {
  runApp( MaterialApp(
    title: 'Bitcamp',
    home: const StartRoute(title: 'BitCamp',),
     theme: ThemeData(scaffoldBackgroundColor:  Color.fromARGB(255, 238, 212, 238)),
    debugShowCheckedModeBanner: false,
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
  String message1 = 'Drag and drop your malware sample here to analyze it';
  bool highlighted1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Malware Mayhem!'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
                child: Container(
                  color: highlighted1 ? Color.fromARGB(85, 188, 95, 204) : Colors.transparent,
                  child: Stack(
                    children: [
                      buildZone1(context),
                      Center(child: Text(message1, style: const TextStyle(fontSize: 20),)),
                    ],
                  ),
                ),
              ),
          ElevatedButton(
            child: const Text('Analyze File'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
            onPressed: () async {

              var string_data = await getData('http://127.0.0.1:5000/analyze');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoRoute(data: string_data)),
              );
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        ]
      ),
    );
  }
  Widget get _rectBorderWidget {
      return DottedBorder(
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
          height: 200,
          width: 120,
          color: Color.fromARGB(125, 204, 98, 223)
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
              message1 = '${ev.name} is ready to be analyzed!';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(ev);
            var md5_hash = md5.convert(bytes);
            print("Digest as hex string: $md5_hash");
            my_hash = md5_hash.toString();
            // print(bytes.sublist(0, 20));

          },
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      );
}


Future getData(url) async {
  print("my hash is THISHKVHCGJHJLOHIGKH ${my_hash}");
  var response = await post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"file_hash":my_hash})
  );
  
  return response.body;
}