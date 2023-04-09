import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bitcamp_flutter/result.dart';

String malware_type = "nope";

class Malware {
  String name;
  String md5;
  List<Section>? sections;
  Malware(this.name, this.md5, [this.sections]);  

  factory Malware.fromJson(dynamic json) {
    if (json['sections'] != null && json['imports'] != null) {
      var sectionObjsJson = json['sections'] as List;
      List<Section> _section = sectionObjsJson.map((tagJson) => Section.fromJson(tagJson)).toList();

      return Malware(
        json['name'] as String,
        json['md5'] as String,
        _section
      );
    } else {
      return Malware(
        json['name'] as String,
        json['md5'] as String,
      );
    }
  }
}

class Section {
  String name;
  double entropy;
  int raw_size, virtual_size;

  Section(this.name, this.entropy, this.raw_size, this.virtual_size);

  factory Section.fromJson(dynamic json) {
    return Section(json['name'] as String, json['entropy'] as double, json['raw_size'] as int, json['virtual_size'] as int);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.entropy}, ${this.raw_size}, ${this.virtual_size} }';
  }
}
class Malware2 {
  String name;
  String md5;
  List<Imports>? imports;
  Malware2(this.name, this.md5, [this.imports]);

  factory Malware2.fromJson(dynamic json) {
    if (json['sections'] != null && json['imports'] != null) {
      var importsObjsJson = json['imports'] as List;
      List<Imports> _imports = importsObjsJson.map((tagJson) => Imports.fromJson(tagJson)).toList();


      return Malware2(
        json['name'] as String,
        json['md5'] as String,
        _imports
      );
    } else {
      return Malware2(
        json['name'] as String,
        json['md5'] as String,
      );
    }
  }
}

class Imports {
  String library_name;
  //List<String>? imported_functions;

  //Imports(this.library_name, [this.imported_functions]);
  Imports(this.library_name);


  factory Imports.fromJson(dynamic json) {
    //return Imports(json['library_name'] as String, json['imported_functions'] as List<String>);
    return Imports(json['library_name'] as String);
  }
}
class InfoRoute extends StatelessWidget { 
  String data = '{"none":"nope"}';
  late Map<String, dynamic> malware_info;

  InfoRoute({super.key, required String this.data});

  @override
  Widget build(BuildContext context) {
    malware_info = jsonDecode(data);
    if(malware_info['suggested_threat_label'] != 'nope'){
      malware_type = malware_info['suggested_threat_label'].toString();
    }else{
      malware_type = 'nope';
    }
    
    
    Malware malwareInfo = Malware.fromJson(malware_info );
    Malware2 malwareInfo2 = Malware2.fromJson(malware_info);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Information'),
        backgroundColor: Colors.purple,

      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: Text(malwareInfo.name, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: const Text("File Name"),
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text(malwareInfo.md5, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: const Text("MD5 Hash"),
          ),
          ExpansionTile(
            leading: const Icon(Icons.folder_special_outlined),
            title: const Text("PE File Sections", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: const Text("Imported Dynamic Linked Libraries"),
            children: <Widget>[
              ExpansionTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo.sections![0].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("A file section"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Entropy: ${malwareInfo.sections![0].entropy}",),
                    subtitle: const Text("How random the file is"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Raw Size: ${malwareInfo.sections![0].raw_size}",),
                    subtitle: const Text("How much space the section takes up"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Virtual Size: ${malwareInfo.sections![0].virtual_size}",),
                    subtitle: const Text("How much RAM the section uses"),
                  ),
                ]
              ),
              ExpansionTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo.sections![1].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("A file section"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Entropy: ${malwareInfo.sections![1].entropy}",),
                    subtitle: const Text("How random the file is"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Raw Size: ${malwareInfo.sections![1].raw_size}",),
                    subtitle: const Text("How much space the section takes up"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Virtual Size: ${malwareInfo.sections![1].virtual_size}",),
                    subtitle: const Text("How much RAM the section uses"),
                  ),
                ]
              ),
              ExpansionTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo.sections![2].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("A file section"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Entropy: ${malwareInfo.sections![2].entropy}",),
                    subtitle: const Text("How random the file is"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Raw Size: ${malwareInfo.sections![2].raw_size}",),
                    subtitle: const Text("How much space the section takes up"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Virtual Size: ${malwareInfo.sections![2].virtual_size}",),
                    subtitle: const Text("How much RAM the section uses"),
                  ),
                ]
              ),
              ExpansionTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo.sections![3].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("A file section"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Entropy: ${malwareInfo.sections![3].entropy}",),
                    subtitle: const Text("How random the file is"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Raw Size: ${malwareInfo.sections![3].raw_size}",),
                    subtitle: const Text("How much space the section takes up"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text("Virtual Size: ${malwareInfo.sections![3].virtual_size}",),
                    subtitle: const Text("How much RAM the section uses"),
                  ),
                ]
              ),
            ]
          ),
          ExpansionTile(
            leading: const Icon(Icons.folder_special_outlined),
            title: const Text("Imported DLLs", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: const Text("Imported Dynamic Linked Libraries"),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo2.imports![0].library_name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("An Imported DLL"),
                /*children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text("Function", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("An Imported Function"),
                  ),
                ]*/
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo2.imports![1].library_name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("An Imported DLL"),
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo2.imports![2].library_name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("An Imported DLL"),
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo2.imports![3].library_name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("An Imported DLL"),
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(malwareInfo2.imports![4].library_name, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("An Imported DLL"),
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
            bottom: 30,
            right: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResultRoute(result: "benign", type: malware_type)),
            );
              },
              child: const Text('Not Malware'),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResultRoute(result: "malware", type: malware_type)),
            );
              },
              child: const Text('Malware'),
            ),
          ),
          Positioned(
            left: 50,
            bottom: 30,
            
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
              onPressed: () {
                malware_type = "nope";
                Navigator.pop(context);},
              child: const Text('Analyze Different File'),
            ),
          ),
        ],
      ),
    );
  }
}