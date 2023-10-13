// ignore_for_file: prefer_const_constructors, prefer_final_fields, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_160420033/main.dart';
import 'package:project_160420033/screen/game.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MyMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatiMurup Square',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MainMenu(),
      routes: {
        'game': (context) => Game(),
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuState();
  }
}

class MenuState extends State<MainMenu> {
  String _player1 = "";
  String _player2 = "";
  int _roundCount = 1;
  String _gameDifficulty = "Gampang";

  final _textPlayer1 = TextEditingController();
  final _textPlayer2 = TextEditingController();
  final _textRoundCount = TextEditingController();

  bool _validatePlayer1 = false;
  bool _validatePlayer2 = false;
  bool _validateRoundCount = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _player1 = prefs.getString("player_1") ?? '';
      _player2 = prefs.getString("player_2") ?? '';
      _roundCount = prefs.getInt("round_count") ?? 1;
      _gameDifficulty = prefs.getString("game_diff") ?? "Gampang";

      _textPlayer1.text = _player1;
      _textPlayer2.text = _player2;
      _textRoundCount.text = _roundCount.toString();
    });
  }

  void saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("player_1", _player1);
    prefs.setString("player_2", _player2);
    prefs.setInt("round_count", _roundCount);
    prefs.setString("game_diff", _gameDifficulty);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MatiMurup Square'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child:
                      Text("Setup Permainan", style: TextStyle(fontSize: 20))),
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _textPlayer1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama Pemain #1",
                    errorText: _validatePlayer1
                        ? "Nama Pemain 1 tidak boleh kosong"
                        : null),
                onChanged: (v) {
                  _player1 = v;
                },
              ),
            )),
            Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                controller: _textPlayer2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama Pemain #2",
                    errorText: _validatePlayer2
                        ? "Nama Pemain 2 tidak boleh kosong"
                        : null),
                onChanged: (v) {
                  _player2 = v;
                },
              ),
            )),
            Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _textRoundCount,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Jumlah Ronde",
                    errorText: _validateRoundCount
                        ? "Jumlah Ronde tidak boleh kosong dan harus 1-10"
                        : null),
                onChanged: (v) {
                  _roundCount = int.parse(v);
                },
              ),
            )),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: DropdownButton(
                  isExpanded: true,
                  value: _gameDifficulty,
                  items: const [
                    DropdownMenuItem(
                      child: Text("Gampang"),
                      value: "Gampang",
                    ),
                    DropdownMenuItem(
                      child: Text("Sedang"),
                      value: "Sedang",
                    ),
                    DropdownMenuItem(
                      child: Text("Susah"),
                      value: "Susah",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _gameDifficulty = value!;
                    });
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _textPlayer1.text.isEmpty
                          ? _validatePlayer1 = true
                          : _validatePlayer1 = false;
                      _textPlayer2.text.isEmpty
                          ? _validatePlayer2 = true
                          : _validatePlayer2 = false;
                      (_textRoundCount.text.isEmpty ||
                              int.parse(_textRoundCount.text) < 1 ||
                              int.parse(_textRoundCount.text) > 10)
                          ? _validateRoundCount = true
                          : _validateRoundCount = false;
                    });
                    if (!_validatePlayer1 &&
                        !_validatePlayer2 &&
                        !_validateRoundCount) {
                      saveSettings();
                      Navigator.popAndPushNamed(context, 'game');
                    }
                  },
                  child: Text('Mulai'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
