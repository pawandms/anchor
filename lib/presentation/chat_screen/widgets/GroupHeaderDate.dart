
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/Helper.dart';

class GroupHeaderDate extends StatelessWidget {
  static DateFormat _formatter = DateFormat('yyyy-MM-dd');
  final DateTime date;
  final BuildContext context;
  const GroupHeaderDate({
    required this.context,
    required this.date,
    super.key
  });

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 1.0,
                vertical: 1.0
            ),
            child: Text(
              getText(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

   String getText(DateTime date) {
    final now = new DateTime.now();
    if (_formatter.format(now) == _formatter.format(date)) {
      return 'Today';
    } else if (_formatter
        .format(new DateTime(now.year, now.month, now.day - 1)) ==
        _formatter.format(date)) {
      return 'Yesterday';
    } else {
      return '${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('y').format(date)}';
    }
  }
}