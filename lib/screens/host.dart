import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/waiting_host.dart';

class Host extends StatefulWidget {
  _HostState createState() => _HostState();
}

class _HostState extends State<Host> {
  TextEditingController red_team = TextEditingController();
  TextEditingController red_name = TextEditingController();
  TextEditingController blue_team = TextEditingController();
  TextEditingController blue_name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('진행자'), centerTitle: true),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
              controller: blue_team,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '청 소속',
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
              controller: blue_name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '청 이름',
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
              controller: red_team,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '홍 소속',
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
              controller: red_name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '홍 이름',
              )),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => WaitingHost(
                      this.blue_team.text,
                      this.blue_name.text,
                      this.red_team.text,
                      this.red_name.text),
                ));
              },
              child: Text('매치 생성')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('이전'))
        ])
      ])),
    );
  }
}
