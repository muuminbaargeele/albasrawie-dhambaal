import 'package:intl/intl.dart';

String formatChatTimestamp(String timestamp) {
  final now = DateTime.now();
  final messageTime = DateTime.parse(timestamp).toLocal(); // UTC → Local

  final today = DateTime(now.year, now.month, now.day);
  final messageDay = DateTime(
    messageTime.year,
    messageTime.month,
    messageTime.day,
  );

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

String formatChatTime(String? isoString, {bool is24h = false}) {
  if (isoString == null || isoString.isEmpty) return '';

  try {
    final dateTime = DateTime.parse(isoString).toLocal();
    final format = is24h ? DateFormat.Hm() : DateFormat.jm(); // HH:mm or h:mm a
    return format.format(dateTime);
  } catch (e) {
    return '';
  }
}
