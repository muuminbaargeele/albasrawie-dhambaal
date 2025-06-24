class Receiver {
  final String email;
  final String fullName;
  final String image;
  final String phone;
  final int traineeId;

  Receiver({
    required this.email,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.traineeId,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    email: json['receiver_email'],
    fullName: json['receiver_full_name'],
    image: json['receiver_image'],
    phone: json['receiver_phone'],
    traineeId: json['receiver_trainee_id'],
  );

  Map<String, dynamic> toJson() => {
    'receiver_email': email,
    'receiver_full_name': fullName,
    'receiver_image': image,
    'receiver_phone': phone,
    'receiver_trainee_id': traineeId,
  };
}