class WebSocketEvents {
  /// Triggered when a new message is sent
  static const String newMessage = 'new_message';

  /// Triggered when a user creates or joins a chat
  static const String newChat = 'new_chat';

  /// Triggered when a message is seen by recipient
  static const String messageSeen = 'message_seen';

  /// Triggered when a user is typing
  static const String typing = 'typing';

  /// Triggered when a user goes online/offline
  static const String userStatus = 'user_status';

  /// Triggered for syncing missed messages
  static const String syncMessages = 'sync_messages';

  /// Custom general-purpose error
  static const String error = 'error';
}