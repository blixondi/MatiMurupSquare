// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {
  int _initvalue = 10;
  late int _hitung = _initvalue;
  late Timer _timer;
  late int _urut;
  late bool _boleh_klik;
  List _urutan_nyala = [3, 1, 5, 2, 6, 7, 10];
  List _jawaban = [];
  startTimer() {
    _boleh_klik = false;
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _hitung--;
        if (_hitung <= 0) {
          _urut++;
          if (_urut >= _urutan_nyala.length - 1) {
            _timer.cancel();
            _boleh_klik = true;
          }
          _hitung = _initvalue;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _urut = 0;
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Divider(
          height: 10,
        ),
        Container(
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Define different colors for each grid item
              List<Color> colors = [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.teal,
                Colors.pinkAccent,
                Colors.indigo,
              ];

              return (index == (_urutan_nyala[_urut] - 1))
                  ? Container(
                      color: colors[index],
                      margin:
                          EdgeInsets.all(2.0), // Add some margin for spacing
                    )
                  : _boleh_klik
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _jawaban.add(index + 1);
                            });
                          },
                          child: Container(
                            color: colors[index],
                            margin: EdgeInsets.all(2.0),
                          ),
                        )
                      : Container(
                          color: Colors.grey,
                          margin: EdgeInsets.all(2.0),
                        );
            },
          ),
          height: 400,
        ),
        Text(
          _jawaban.join(', '), // Convert the array to a comma-separated string
          style: TextStyle(fontSize: 24),
        )
      ])),
    );
  }
}
