class ChatParticipant {
  final int chatId;
  final String? content;
  final int createBy;
  final String createdAt;
  final dynamic deletedBy;
  final dynamic deliveredAt;
  final String? groupDesc;
  final String groupName;
  final int? isDeleted;
  final int isGroup;
  final int? messageId;
  final String? messageType;
  final int? quotedMessageId;
  final String receiverEmail;
  final String receiverFullName;
  final int? receiverId;
  final String receiverImage;
  final String receiverPhone;
  final int receiverTraineeId;
  final dynamic seenAt;
  final String senderFullName;
  final int? senderId;
  final String senderImage;
  final String senderPhone;
  final int senderTraineeId;
  final String? sentAt;
  final String? status;

  ChatParticipant({
    required this.chatId,
    required this.content,
    required this.createBy,
    required this.createdAt,
    required this.deletedBy,
    required this.deliveredAt,
    required this.groupDesc,
    required this.groupName,
    required this.isDeleted,
    required this.isGroup,
    required this.messageId,
    required this.messageType,
    required this.quotedMessageId,
    required this.receiverEmail,
    required this.receiverFullName,
    required this.receiverId,
    required this.receiverImage,
    required this.receiverPhone,
    required this.receiverTraineeId,
    required this.seenAt,
    required this.senderFullName,
    required this.senderId,
    required this.senderImage,
    required this.senderPhone,
    required this.senderTraineeId,
    required this.sentAt,
    required this.status,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      chatId: json['chat_id'],
      content: json['content'],
      createBy: json['create_by'],
      createdAt: json['created_at'],
      deletedBy: json['deleted_by'],
      deliveredAt: json['delivered_at'],
      groupDesc: json['group_desc'],
      groupName: json['group_name'],
      isDeleted: json['is_deleted'],
      isGroup: json['is_group'],
      messageId: json['message_id'],
      messageType: json['message_type'],
      quotedMessageId: json['quoted_message_id'],
      receiverEmail: json['receiver_email'],
      receiverFullName: json['receiver_full_name'],
      receiverId: json['receiver_id'],
      receiverImage: json['receiver_image'],
      receiverPhone: json['receiver_phone'],
      receiverTraineeId: json['receiver_trainee_id'],
      seenAt: json['seen_at'],
      senderFullName: json['sender_full_name'],
      senderId: json['sender_id'],
      senderImage: json['sender_image'],
      senderPhone: json['sender_phone'],
      senderTraineeId: json['sender_trainee_id'],
      sentAt: json['sent_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'content': content,
      'create_by': createBy,
      'created_at': createdAt,
      'deleted_by': deletedBy,
      'delivered_at': deliveredAt,
      'group_desc': groupDesc,
      'group_name': groupName,
      'is_deleted': isDeleted,
      'is_group': isGroup,
      'message_id': messageId,
      'message_type': messageType,
      'quoted_message_id': quotedMessageId,
      'receiver_email': receiverEmail,
      'receiver_full_name': receiverFullName,
      'receiver_id': receiverId,
      'receiver_image': receiverImage,
      'receiver_phone': receiverPhone,
      'receiver_trainee_id': receiverTraineeId,
      'seen_at': seenAt,
      'sender_full_name': senderFullName,
      'sender_id': senderId,
      'sender_image': senderImage,
      'sender_phone': senderPhone,
      'sender_trainee_id': senderTraineeId,
      'sent_at': sentAt,
      'status': status,
    };
  }
}