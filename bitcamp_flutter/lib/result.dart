import 'package:flutter/material.dart';

class ResultRoute extends StatelessWidget {
  String result;
  
  String type;

  ResultRoute({super.key, required String this.result, required String this.type});

  @override
  Widget build(BuildContext context) {
    print(type);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results!'),
        backgroundColor: Colors.purple,

      ),
      body:
        Column(
          children: [
            (result == 'malware' && type != 'nope') || (result == 'benign' && type == 'nope')? Padding(padding: EdgeInsets.all(15), child: Text("Congratulations! You guessed correctly!", style:TextStyle(fontSize: 25))): Padding(padding: EdgeInsets.all(15), child:Text("Sorry, you are incorrect", style:TextStyle(fontSize: 25))),
            type != 'nope' ? Padding(padding: EdgeInsets.all(15), child: Text("This file has been popularly identified as ${type}", style:TextStyle(fontSize: 20))): Padding(padding: EdgeInsets.all(15), child:Text("This file is most likely not malware", style:TextStyle(fontSize: 20))),
            const ExpansionTile(
              title: Text("Imports"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                  "Most programs use external functions to run. These functions are imported from libraries, and are then used when. Few imports and the presence of the GetProcAddress and LoadLibrary functions may be an indicator of runtime linking. Runtime linking is a technique malware uses to obfuscate custom functions or standard functions that are commonly used in malware.",
                  style: TextStyle(fontSize: 17),
                ),
                )
              ],
            ),
            const ExpansionTile(
              title: Text("Entropy"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                  "The section entropy measures the randomness of each section of the file. Lower numbers suggest a lower level of randomness, while higher numbers indicate a higher level of randomness. Normally files are not very random. They contain a ton of empty space. However, if a malicious actor tries to hide the contents of a file, it will appear random. A disguised file will have at least one section with very high entropy, usually greater than 7.",
                  style: TextStyle(fontSize: 17),
                ),
                )
              ],
            ),
            const ExpansionTile(
              title: Text("Size"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                  "Another indicator of malware is the presence of sections with a large virtual size but a small raw size. This can be a sign that someone has packed the malware. Malware packing is an obfuscation technique, where the program essentially writes itself as it runs. This makes it hard for people to detect malware in static files. Typically packed malware files have a large virtual size when compared to the raw size. Not all packed files are malware but combined with other factors, it could be an indicator of malware.",
                  style: TextStyle(fontSize: 17),
                ),
                )
              ],
            ),
            const ExpansionTile(
              title: Text("Names"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                  "Most executable files have several sections, such as .text and .data to name the most common. Abnormal section names may indicate the file has been packed. Typically, packed files are used to hide the true purpose of the code. Abnormal section names means that someone is hiding their code from you, probably for a nefarious reason.",
                  style: TextStyle(fontSize: 17),
                ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
              onPressed: () {
                type = "nope";
                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
              },
              child: const Text('Go back!'),
            ),
          ]
        ),
    );
  }
}