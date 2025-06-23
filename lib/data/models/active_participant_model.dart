class ActiveParticipant {
  final String imagePath;
  final String myDate;
  final String traineeEmail;
  final String traineeFullName;
  final int traineeId;
  final String traineePhoneNumber;
  final String traineeStatus;

  ActiveParticipant({
    required this.imagePath,
    required this.myDate,
    required this.traineeEmail,
    required this.traineeFullName,
    required this.traineeId,
    required this.traineePhoneNumber,
    required this.traineeStatus,
  });

  factory ActiveParticipant.fromJson(Map<String, dynamic> json) {
    return ActiveParticipant(
      imagePath: json['image_path'],
      myDate: json['my_date'],
      traineeEmail: json['trainee_email'],
      traineeFullName: json['trainee_full_name'],
      traineeId: json['trainee_id'],
      traineePhoneNumber: json['trainee_phone_number'],
      traineeStatus: json['trainee_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'my_date': myDate,
      'trainee_email': traineeEmail,
      'trainee_full_name': traineeFullName,
      'trainee_id': traineeId,
      'trainee_phone_number': traineePhoneNumber,
      'trainee_status': traineeStatus,
    };
  }
}