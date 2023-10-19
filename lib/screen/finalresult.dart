import 'package:flutter/material.dart';
import 'package:project_160420033/screen/game.dart';
import 'package:project_160420033/screen/mainmenu.dart';

class FinalResult extends StatelessWidget {
  final List<String> roundList;
  final String player1;
  final String player2;

  FinalResult(this.roundList, this.player1, this.player2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Result'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Hasil Permainan'),
            Text(
              '$player1 vs $player2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Card(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Ronde')),
                    DataColumn(label: Text('Hasil')),
                  ],
                  rows: roundList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String round = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(round)),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Game())),
                              ModalRoute.withName('/game'));
                        },
                      child: Text('Main Lagi')),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => MainMenu())),
                              ModalRoute.withName('/'));
                        },
                        child: Text('Menu Utama'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
