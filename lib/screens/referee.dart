import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/waiting_referee.dart';
import 'dart:async';
import 'dart:io';

class Referee extends StatefulWidget {
  _RefereeState createState() => _RefereeState();
}

class _RefereeState extends State<Referee> {
  TextEditingController ip_address = TextEditingController();
  TextEditingController port_num = TextEditingController();
  List<String> message = [];

  FutureOr<Socket?> connectToServer(String ip, int port) async {
    try {
      Socket socket = await Socket.connect(ip, port);
      print('Connected to server: $ip:$port');
      return socket;
    } catch (e) {
      return null;
    }
  }

  Future<void> recieveInformation(Socket socket) async {
    await socket.forEach((List<int> data) {
      final receivedMessage = String.fromCharCodes(data).trim();
      setState(() {
        message.add(receivedMessage);
      });
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('부심'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: ip_address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'IP주소',
                  )),
              TextField(
                  controller: port_num,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '포트번호',
                  )),
              ElevatedButton(
                  onPressed: () {
                    var socket = connectToServer(
                        ip_address.text, int.parse(port_num.text));
                    if (socket != null && socket is Socket) {
                      recieveInformation(socket);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => WaitingReferee(
                            message[0],
                            message[1],
                            message[2],
                            message[3],
                            3,
                            60,
                            socket),
                      ));
                    }
                  },
                  child: Text('참여'))
            ],
          ),
        ));
  }
}
