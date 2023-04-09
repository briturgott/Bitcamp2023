import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bitcamp_flutter/result.dart';

class InfoRoute extends StatelessWidget {
  String data = '{"none":"nope"}';
  late Map<String, dynamic> malware_info;

  InfoRoute({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    malware_info = jsonDecode(data);
    print("\n\n\n\n\n\n\n\n\n\n\n\n");
    print(malware_info);
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Information'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.insert_drive_file_outlined),
            title: Text("${malware_info["name"]}", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("File Name"),
          ),
          ListTile(
            leading: Icon(Icons.numbers),
            title: Text("${malware_info["md5"]}", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("MD5 Hash"),
          ),
          ExpansionTile(
            leading: Icon(Icons.folder_special_outlined),
            title: Text("PE File Sections", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Imported Dynamic Linked Libraries"),
            children: <Widget>[
              ExpansionTile(
                leading: Icon(Icons.insert_drive_file_outlined),
                title: Text("Section Name", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("A file section"),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text("Entropy: ", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("How random the file is"),
                  ),
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text("Raw Size: ", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("How much space the section takes up"),
                  ),
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text("Virtual Size: ", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("How much RAM the section uses"),
                  ),
                ]
              ),
            ]
          ),
          ExpansionTile(
            leading: Icon(Icons.folder_special_outlined),
            title: Text("Imported DLLs", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Imported Dynamic Linked Libraries"),
            children: <Widget>[
              ExpansionTile(
                leading: Icon(Icons.insert_drive_file_outlined),
                title: Text("DLL 1", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("An Imported DLL"),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text("Function", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("An Imported Function"),
                  ),
                ]
              ),
            ]
          ),
          ExpansionTile(
            leading: Icon(Icons.drive_folder_upload),
            title: Text("Exports", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Exported Functions"),
            children: <Widget>[
              ListTile(
                title: Text("Export 1", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("An Exported Function"),
              ),
            ]
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResultRoute()),
            );
              },
              child: const Text('Not Malware'),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResultRoute()),
            );
              },
              child: const Text('Malware'),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text('Analyze Different File'),
            ),
          ),
        ],
      ),
    );
  }
}