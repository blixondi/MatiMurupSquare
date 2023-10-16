// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:project_160420033/screen/roundresult.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {
  late String _player1 = "";
  late String _player2 = "";
  late String _gameDifficulty = "";
  late int _roundCount = 0;

  int _initvalue = 10;
  int _currentPlayer = 1;
  int _currentRound = 1;
  int _currentIndex = 0;

  var random = Random();

  String _player1status = "";
  String _player2status = "";
  String roundresult = "";

  late int _hitung = _initvalue;
  late Timer _timer;
  late int _urut;
  late bool _boleh_klik = false;

  List _urutan_nyala = [];
  List _jawaban1 = [];
  List _jawaban2 = [];
  List _roundTracker = [];

  resetAll() {
    _currentRound++;
    _urut = 0;
    _initvalue = 10;
    _hitung = _initvalue;
    _urutan_nyala = [];
    _jawaban1 = [];
    _jawaban2 = [];
  }

  switchPlayer() {
    _urut = 0;
    _initvalue = 10;
    _hitung = _initvalue;
    _currentIndex = 0;
    if (_currentPlayer == 1) {
      _currentPlayer = 2;
    } else if (_currentPlayer == 2) {
      _currentPlayer = 1;
    }
    startTimer();
  }

  loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _player1 = prefs.getString("player_1") ?? '';
      _player2 = prefs.getString("player_2") ?? '';
      _roundCount = prefs.getInt("round_count") ?? 1;
      _gameDifficulty = prefs.getString("game_diff") ?? "Gampang";
    });
  }

  randomize() {
    int sequence = 0;
    int addedNumber = 0;
    if (_gameDifficulty == "Gampang") {
      sequence = 5;
    } else if (_gameDifficulty == "Sedang") {
      sequence = 8;
    } else if (_gameDifficulty == "Susah") {
      sequence = 12;
    }
    for (var i = 0; i < sequence; i++) {
      _urutan_nyala.add(random.nextInt(9) + 1);
    }
    _urutan_nyala.add(10);
  }

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
    //randomize();
    // TODO: implement initState
    super.initState();
    _urut = 0;
    initialization();
  }

  void initialization() async {
    await loadSettings();
    _urutan_nyala.clear();
    randomize();
    startTimer();
    print(_urutan_nyala);
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
        title: Text('MatiMurup Square'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Giliran ' + (_currentPlayer == 1 ? _player1 : _player2),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Text(
              (_boleh_klik ? 'Tekan Tombol Sesuai Urutan' : 'Hapalkan Polanya'),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
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

              return (_urut < _urutan_nyala.length &&
                      index == (_urutan_nyala[_urut] - 1))
                  ? Container(
                      color: colors[index],
                      margin:
                          EdgeInsets.all(2.0), // Add some margin for spacing
                    )
                  : _boleh_klik
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_currentPlayer == 1) {
                                _jawaban1.add(index + 1);
                                if (_jawaban1[_currentIndex] !=
                                    _urutan_nyala[_currentIndex]) {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                              'Urutan Salah',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text('Sayang sekali ' +
                                                _player1 +
                                                ', kamu menekan urutan yang salah.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'OK');
                                                  _player1status = "lose";
                                                  setState(() {
                                                    switchPlayer();
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                }
                                _currentIndex++;
                                print('current jawaban1 array:');
                                print(_jawaban1);
                                if (_jawaban1.length ==
                                    _urutan_nyala.length - 1) {
                                  print('stop clicking');
                                  _player1status = "win";
                                  switchPlayer();
                                }
                              } else {
                                _jawaban2.add(index + 1);
                                if (_jawaban2[_currentIndex] !=
                                    _urutan_nyala[_currentIndex]) {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                              'Urutan Salah',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text('Sayang sekali ' +
                                                _player2 +
                                                ', kamu menekan urutan yang salah.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'OK');
                                                  _player2status = "lose";
                                                  switchPlayer();
                                                  resetAll();
                                                  initialization();
                                                  if (_player1status ==
                                                      _player2status) {
                                                    roundresult = "SEIMBANG";
                                                  } else if (_player1status ==
                                                      "win") {
                                                    roundresult = _player1;
                                                  } else if (_player2status ==
                                                      "win") {
                                                    roundresult = _player2;
                                                  }
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RoundResult(
                                                                  _currentRound,
                                                                  _roundCount,
                                                                  _player1,
                                                                  _player2,
                                                                  roundresult,
                                                                  _gameDifficulty)));
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                }
                                _currentIndex++;
                                print('current jawaban2 array:');
                                print(_jawaban2);
                                if (_jawaban2.length ==
                                    _urutan_nyala.length - 1) {
                                  _player2status = "win";
                                  print('stop clicking');
                                  switchPlayer();
                                  resetAll();
                                  initialization();
                                  if (_player1status == _player2status) {
                                    roundresult = "SEIMBANG";
                                  } else if (_player1status == "win") {
                                    roundresult = _player1;
                                  } else if (_player2status == "win") {
                                    roundresult = _player2;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RoundResult(
                                              _currentRound,
                                              _roundCount,
                                              _player1,
                                              _player2,
                                              roundresult,
                                              _gameDifficulty)));
                                }
                              }
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
        Text('Ronde ' + _currentRound.toString()),
        Text('Level: ' + _gameDifficulty),
        Text(
          (_currentPlayer == 1 ? _jawaban1.join(', ') : _jawaban2.join(', ')),
          // Convert the array to a comma-separated string
          style: TextStyle(fontSize: 24),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                resetAll();
                initialization();
              });
            },
            child: Text('Change Round'))
      ])),
    );
  }
}
