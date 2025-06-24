class ChatMessage {
  final String? content;
  final dynamic deletedBy;
  final dynamic deliveredAt;
  final String? groupDesc;
  final String groupName;
  final int? isDeleted;
  final int isGroup;
  final int? messageId;
  final String? messageType;
  final int? quotedMessageId;
  final int? receiverId;
  final dynamic seenAt;
  final int? senderId;
  final String? sentAt;
  final String? status;

  ChatMessage({
    required this.content,
    required this.deletedBy,
    required this.deliveredAt,
    required this.groupDesc,
    required this.groupName,
    required this.isDeleted,
    required this.isGroup,
    required this.messageId,
    required this.messageType,
    required this.quotedMessageId,
    required this.receiverId,
    required this.seenAt,
    required this.senderId,
    required this.sentAt,
    required this.status,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    content: json['content'],
    deletedBy: json['deleted_by'],
    deliveredAt: json['delivered_at'],
    groupDesc: json['group_desc'],
    groupName: json['group_name'],
    isDeleted: json['is_deleted'],
    isGroup: json['is_group'],
    messageId: json['message_id'],
    messageType: json['message_type'],
    quotedMessageId: json['quoted_message_id'],
    receiverId: json['receiver_id'],
    seenAt: json['seen_at'],
    senderId: json['sender_id'],
    sentAt: json['sent_at'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'content': content,
    'deleted_by': deletedBy,
    'delivered_at': deliveredAt,
    'group_desc': groupDesc,
    'group_name': groupName,
    'is_deleted': isDeleted,
    'is_group': isGroup,
    'message_id': messageId,
    'message_type': messageType,
    'quoted_message_id': quotedMessageId,
    'receiver_id': receiverId,
    'seen_at': seenAt,
    'sender_id': senderId,
    'sent_at': sentAt,
    'status': status,
  };
}