import 'package:flutter/material.dart';
import 'package:project_160420033/screen/finalresult.dart';

class RoundResult extends StatelessWidget {
  final int currentRound;
  final int roundCount;
  final String player1;
  final String player2;
  final String result;
  final String difficulty;
  final List roundList;
  RoundResult(this.currentRound, this.roundCount, this.player1, this.player2,
      this.result, this.difficulty, this.roundList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round Result'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('Hasil Ronde $currentRound (Level: $difficulty)'),
          Text('$player1 VS $player2'),
          Text('$result'),
          ElevatedButton(
              onPressed: () {
                if (currentRound == roundCount) {
                  Navigator.popAndPushNamed(context, FinalResult(roundList) as String);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text((currentRound == roundCount)
                  ? 'Lihat hasil akhir'
                  : 'Lanjut Ronde $currentRound'))
        ],
      )),
    );
  }
}
