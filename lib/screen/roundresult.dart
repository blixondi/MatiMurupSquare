import 'package:flutter/material.dart';

class RoundResult extends StatelessWidget {
  final int currentRound;
  final int roundCount;
  final String player1;
  final String player2;
  final String result;
  final String difficulty;
  RoundResult(this.currentRound, this.roundCount, this.player1, this.player2,
      this.result, this.difficulty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('Hasil Ronde $currentRound (Level: $difficulty)'),
          Text('$player1 VS $player2'),
          Text('$result'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, child: Text('Lanjut Ronde $currentRound'))
        ],
      )),
    );
  }
}
