import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class MatchReferee extends StatefulWidget {
  Socket socket;
  MatchReferee(this.socket);
  _MatchReferee createState() => _MatchReferee();
}

class _MatchReferee extends State<MatchReferee> {
  _MatchRefereeState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.blue,
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('청 주먹');
                  },
                  child: Text('주먹', style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('청 얼굴');
                  },
                  child: Text('얼굴', style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('청 몸통');
                  },
                  child: Text('몸통', style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
        Material(
          color: Colors.red,
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('홍 주먹');
                  },
                  child: Text('주먹', style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('홍 얼굴');
                  },
                  child: Text('얼굴', style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, shape: CircleBorder()),
                  onPressed: () {
                    widget.socket.write('홍 몸통');
                  },
                  child: Text('몸통', style: TextStyle(color: Colors.white))),
            ],
          ),
        )
      ],
    );
  }
}
