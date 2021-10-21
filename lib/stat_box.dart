import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatBox extends StatelessWidget {
  final String title;
  final int total;
  final Color bgcolor;

  const StatBox({Key key, this.title, this.total, this.bgcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, //ขนาดกล่อง
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bgcolor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, //ลงล่าง
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, color: Colors.white)),
          Expanded(
            child: Text(
              '${NumberFormat("#,###").format(total) ?? "..."}',
              style: TextStyle(fontSize: 50, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
