import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDateText extends StatelessWidget {
  final dynamic dateTime; // Può essere DateTime o Timestamp
  final bool showTime;

  FormattedDateText({
    required this.dateTime,
    required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = _getTextColor(dateTime);
    String formattedDate = _formatDate(dateTime, showTime);

    return Text(
      formattedDate,
      style: TextStyle(fontSize: 14, color: textColor),
    );
  }

  String _formatDate(dynamic dateTime, bool showTime) {
    DateTime convertedDateTime;

    // Verifica se dateTime è di tipo Timestamp
    if (dateTime is Timestamp) {
      // Converte il Timestamp in DateTime
      convertedDateTime = dateTime.toDate();
    } else if (dateTime is DateTime) {
      convertedDateTime = dateTime;
    } else {
      // Gestione di altri casi o errori
      return ''; // O gestisci in un altro modo, a seconda delle tue esigenze
    }

    DateTime today = DateTime.now().toLocal();
    DateTime tomorrow = DateTime.now().toLocal().add(Duration(days: 1));

    if (convertedDateTime.isAtSameMomentAs(today) || convertedDateTime.isAtSameMomentAs(tomorrow)) {
      return showTime ? DateFormat('LT').format(convertedDateTime) : DateFormat.yMMMd().add_jm().format(convertedDateTime);
    } else if (convertedDateTime.isBefore(today)) {
      return showTime ? DateFormat('LLLL').format(convertedDateTime) : DateFormat.yMMMd().format(convertedDateTime);
    } else {
      return showTime ? DateFormat('LLLL').format(convertedDateTime) : DateFormat.yMMMd().format(convertedDateTime);
    }
  }

  Color _getTextColor(dynamic dateTime) {
    DateTime convertedDateTime;

    if (dateTime is Timestamp) {
      convertedDateTime = dateTime.toDate();
    } else if (dateTime is DateTime) {
      convertedDateTime = dateTime;
    } else {
      return Colors.black; // O gestisci in un altro modo, a seconda delle tue esigenze
    }

    DateTime today = DateTime.now().toLocal();

    if (convertedDateTime.isBefore(today.add(Duration(days: 1)))) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
