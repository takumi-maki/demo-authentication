import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialog/alert_dialog.dart';

class CheckItem {
  String id;
  String roomId;
  int type;
  int month;
  String text;
  bool isChecked;

  CheckItem({
    required this.id,
    required this.roomId,
    required this.type,
    required this.month,
    required this.text,
    required this.isChecked,
  });
}

class CheckListPage extends ConsumerWidget {
  CheckListPage({Key? key}) : super(key: key);

  final List<Map> _items = [
    {
      "type": 1,
      "month": 1,
      "text": "モビールなどを見る",
      "isChecked": true
    },
    {
      "type": 1,
      "month": 1,
      "text": "腹ばいができる",
      "isChecked": false
    },
    {
      "type": "1",
      "month": "23",
      "text": "首がすわる",
      "isChecked": false
    }
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        DataTable(
          showCheckboxColumn: false,
          columns: const [
            DataColumn(
                label: SizedBox(
                  width: 50,
                  child: Text('age'),
                )
            ),
            DataColumn(
                label: Text('item')),
            DataColumn(
                label: SizedBox(
                  width: 10,
                )
            ),
          ],
          rows: _items.map((item) =>
              DataRow(
                  cells: [
                    DataCell(Text("${item['month'].toString()}ヶ月")),
                    DataCell(onTap: () {
                      debugPrint(item.toString());
                    }, Text(item['text'])),
                    DataCell(
                        onTap: () {
                          item['isChecked']
                            ? cancelAlertDialog(context, item['text'])
                            : achieveAlertDialog(context, item['text']);
                        },
                        item['isChecked']
                            ? const Icon(
                            Icons.military_tech_rounded, color: Colors.amber)
                            : const Icon(
                            Icons.military_tech_rounded, color: Colors.grey)
                    ),
                  ]
              )
          ).toList()
        ),
      ],
    );
  }
}
