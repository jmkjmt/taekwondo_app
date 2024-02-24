// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/match_host.dart';
import 'dart:io';

class WaitingHost extends StatefulWidget {
  String red_team;
  String blue_name;
  String blue_team;
  String red_name;
  WaitingHost(this.blue_team, this.blue_name, this.red_team, this.red_name);

  _WaitingHostState createState() => _WaitingHostState();
}

class _WaitingHostState extends State<WaitingHost> {
  String matchNum = '3회전';
  TextEditingController matchTime = TextEditingController();
  int client_num = 0;
  List<Socket> clients = [];
  late ServerSocket server;
  _WaitingHostState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  @override
  void initState() {
    startServer();
  }

  Future<void> startServer() async {
    try {
      server = await ServerSocket.bind('ip_address', 12345);

      await for (var socket in server) {
        if (client_num < 3) {
          handleClient(socket);
          setState(() {
            client_num++;
            clients.add(socket);
          });
        } else {
          print(
              'Connection limit reached. Rejecting client ${socket.remoteAddress}:${socket.remotePort}');
          socket.close();
        }
      }
    } catch (e) {
      print('Error starting server: $e');
    }
  }

  void handleClient(Socket socket) {
    List<String> messages = [
      widget.blue_team,
      widget.blue_name,
      widget.red_team,
      widget.red_name
    ];
    messages.forEach((message) {
      socket.writeln(message);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP: '),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 75,
                    height: 75,
                    child: Image.asset('assets/waiting_blue.png')),
              ),
              Material(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      child: TextField(
                          controller: matchTime,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '경기시간(초)',
                          )),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: DropdownButton<String>(
                        value: matchNum,
                        onChanged: (String? newValue) {
                          setState(() {
                            matchNum = newValue!;
                          });
                        },
                        items: ['1회전', '2회전', '3회전', '자유']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: 75,
                  height: 75,
                  child: Image.asset('assets/waiting_red.png')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                    child: Column(
                  children: [
                    Text('청 코너'),
                    Text('소속: ' + widget.blue_team),
                    Text('이름: ' + widget.blue_name),
                  ],
                )),
                Material(
                    child: Column(
                  children: [
                    Text('홍 코너'),
                    Text('소속: ' + widget.red_team),
                    Text('이름: ' + widget.red_name),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(child: Text('심판' + client_num.toString())),
          ),
          ElevatedButton(
            onPressed: () {
              for (var socket in clients) {
                socket.write('Start!');
              }
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MatchHost(
                    widget.blue_team,
                    widget.blue_name,
                    widget.red_team,
                    widget.red_name,
                    matchNum,
                    int.parse(matchTime.text),
                    clients,
                    client_num),
              ));
            },
            child: Text('매치 시작'),
          )
        ],
      ),
    );
  }
}
