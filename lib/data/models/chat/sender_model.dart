class Sender {
  final String fullName;
  final String image;
  final String phone;
  final int traineeId;

  Sender({
    required this.fullName,
    required this.image,
    required this.phone,
    required this.traineeId,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    fullName: json['sender_full_name'],
    image: json['sender_image'],
    phone: json['sender_phone'],
    traineeId: json['sender_trainee_id'],
  );

  Map<String, dynamic> toJson() => {
    'sender_full_name': fullName,
    'sender_image': image,
    'sender_phone': phone,
    'sender_trainee_id': traineeId,
  };
}