class UserModel {
  final String classType;
  final String fullName;
  final int traineeId;
  final String phoneNumber;
  final String status;

  UserModel({
    required this.classType,
    required this.fullName,
    required this.traineeId,
    required this.phoneNumber,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      classType: json['class_type'],
      fullName: json['trainee_full_name'],
      traineeId: json['traince_id'],
      phoneNumber: json['traince phone numbex'],
      status: json['traince_status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'class_type': classType,
        'trainee_full_name': fullName,
        'traince_id': traineeId,
        'traince phone numbex': phoneNumber,
        'traince_status': status,
      };
}