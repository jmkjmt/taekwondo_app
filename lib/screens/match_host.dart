// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';

class MatchHost extends StatefulWidget {
  String blue_team;
  String blue_name;
  String red_team;
  String red_name;
  String matchNum;
  int matchTime;
  List<Socket> clients;
  int client_num;
  MatchHost(this.blue_name, this.blue_team, this.red_name, this.red_team,
      this.matchNum, this.matchTime, this.clients, this.client_num);
  _MatchHost createState() => _MatchHost();
}

class _MatchHost extends State<MatchHost> {
  int round = -1;
  late int time;

  int blue_score = 0;
  int red_score = 0;
  int blue_warn = 0;
  int red_warn = 0;
  int blue_head = 0;
  int blue_body = 0;
  int red_head = 0;
  int red_body = 0;

  int tmp_blue_head = 0;
  int tmp_blue_body = 0;
  int tmp_blue_hand = 0;
  int tmp_red_head = 0;
  int tmp_red_body = 0;
  int tmp_red_hand = 0;

  void initState() {
    if (widget.matchNum != '자유') {
      round = int.parse(widget.matchNum[0]);
    }
    time = widget.matchTime;
    for (int i = 0; i < widget.client_num; i++) {
      widget.clients[i].listen(
        (List<int> data) {
          String message = String.fromCharCodes(data);
          switch (message) {
            case '청 몸통':
              tmp_blue_body++;
              break;
            case '홍 몸통':
              tmp_red_body++;
              break;
            case '청 얼굴':
              tmp_blue_head++;
              break;
            case '홍 얼굴':
              tmp_red_head++;
              break;
            case '청 주먹':
              tmp_blue_hand++;
              break;
            case '홍 주먹':
              tmp_red_hand++;
              break;
          }
        },
        onError: (error) {},
        cancelOnError: true,
      );
    }
    if (tmp_blue_body > widget.client_num / 2) {
      setState(() {
        blue_body++;
        blue_score += 2;
      });

      tmp_blue_body = 0;
    }
    if (tmp_red_body > widget.client_num / 2) {
      setState(() {
        red_body++;
        red_score += 2;
      });

      tmp_red_body = 0;
    }
    if (tmp_blue_head > widget.client_num / 2) {
      setState(() {
        blue_head++;
        blue_score += 3;
      });

      tmp_blue_head = 0;
    }
    if (tmp_red_head > widget.client_num / 2) {
      setState(() {
        red_head++;
        red_score += 3;
      });

      tmp_red_head = 0;
    }
    if (tmp_blue_hand > widget.client_num / 2) {
      setState(() {
        blue_score += 1;
      });

      tmp_blue_hand = 0;
    }
    if (tmp_red_hand > widget.client_num / 2) {
      setState(() {
        red_score += 1;
      });

      tmp_red_hand = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Material(
                color: Colors.blue,
                child: Center(
                    child: Column(
                  children: [Text(widget.blue_team), Text(widget.blue_name)],
                )),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.red,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      widget.red_team,
                    ),
                    Text(widget.red_name)
                  ],
                )),
              ),
            ),
          ],
        ),
        Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            blue_score.toString(),
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  child: Material(
                    color: Colors.black,
                    textStyle: TextStyle(color: Colors.yellow),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('round'),
                        Text(round.toString()),
                        Text(time.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            red_score.toString(),
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Material(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star),
                      Icon(Icons.star),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star),
                      Icon(Icons.star),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
