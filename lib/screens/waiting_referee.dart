// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/match_referee.dart';
import 'dart:io';
import 'dart:async';

class WaitingReferee extends StatefulWidget {
  String red_team;
  String blue_name;
  String blue_team;
  String red_name;
  int _matchTime;
  int _matchNum;
  Socket socket;
  WaitingReferee(this.blue_team, this.blue_name, this.red_team, this.red_name,
      this._matchNum, this._matchTime, this.socket);

  _WaitingRefereeState createState() => _WaitingRefereeState();
}

class _WaitingRefereeState extends State<WaitingReferee> {
  List<String> referee = [];
  int ref_num = 0;
  _WaitingRefereeState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  @override
  void initState() {
    super.initState();
    widget.socket.listen((List<int> data) {
      final receivedMessage = String.fromCharCodes(data).trim();
      if (receivedMessage == 'Start!') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MatchReferee(widget.socket),
          ),
        );
      } else if (receivedMessage.substring(0, 7) == 'referee') {
        int referee_num = int.parse(receivedMessage.substring(8));
        setState(() {
          ref_num = referee_num;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('부심 대기실'),
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
                        child: Material(
                          child: Text('경기시간: ' + widget._matchTime.toString()),
                        )),
                    Container(
                        height: 50,
                        width: 200,
                        child: Material(
                          child: Text('매치 횟수: ' + widget._matchNum.toString()),
                        ))
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
            child: Material(child: Text('심판: ' + ref_num.toString())),
          ),
        ],
      ),
    );
  }
}
