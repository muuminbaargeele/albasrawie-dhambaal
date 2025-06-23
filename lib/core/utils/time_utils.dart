import 'package:intl/intl.dart';

String formatChatTimestamp(String timestamp) {
  final now = DateTime.now();
  final messageTime = DateTime.parse(timestamp).toLocal();

  final today = DateTime(now.year, now.month, now.day);
  final messageDay = DateTime(messageTime.year, messageTime.month, messageTime.day);

  final difference = today.difference(messageDay).inDays;

  if (difference == 0) {
    return DateFormat.jm().format(messageTime); // e.g. 5:54 AM
  } else if (difference == 1) {
    return 'Yesterday';
  } else if (difference < 7) {
    return DateFormat('EEEE').format(messageTime); // e.g. Monday
  } else {
    return DateFormat('dd/MM/yyyy').format(messageTime); // e.g. 14/07/2025
  }
}