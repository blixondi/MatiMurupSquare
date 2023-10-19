import 'package:flutter/material.dart';

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
      body: Column(
        children: <Widget>[
          Text('Hasil Permainan'),
          Text('$player1 vs $player2'),
          Card(
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
          )
        ],
      ),
    );
  }
}
