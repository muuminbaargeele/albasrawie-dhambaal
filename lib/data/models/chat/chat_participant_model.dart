import './chat_message_model.dart';
import './receiver_model.dart';
import './sender_model.dart';

class ChatParticipant {
  final int chatId;
  final int createBy;
  final String createdAt;
  final List<ChatMessage> chat;
  final Receiver receiver;
  final Sender sender;

  ChatParticipant({
    required this.chatId,
    required this.createBy,
    required this.createdAt,
    required this.chat,
    required this.receiver,
    required this.sender,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) => ChatParticipant(
    chatId: json['chat_id'],
    createBy: json['create_by'],
    createdAt: json['created_at'],
    chat: (json['chat'] as List<dynamic>).map((e) => ChatMessage.fromJson(e)).toList(),
    receiver: Receiver.fromJson(json['receiver']),
    sender: Sender.fromJson(json['sender']),
  );

  Map<String, dynamic> toJson() => {
    'chat_id': chatId,
    'create_by': createBy,
    'created_at': createdAt,
    'chat': chat.map((e) => e.toJson()).toList(),
    'receiver': receiver.toJson(),
    'sender': sender.toJson(),
  };
}