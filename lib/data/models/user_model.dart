class UserModel {
  final String classType;
  final String fullName;
  final int traineeId;
  final String phoneNumber;
  final String status;
  final String imagePath;
  final String instructorEmail;
  final String instructorFullName;
  final String myDate;
  final String traineeDesc;

  UserModel({
    required this.classType,
    required this.fullName,
    required this.traineeId,
    required this.phoneNumber,
    required this.status,
    required this.imagePath,
    required this.instructorEmail,
    required this.instructorFullName,
    required this.myDate,
    required this.traineeDesc,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      classType: json['class_type'],
      fullName: json['trainee_full_name'],
      traineeId: json['trainee_id'],
      phoneNumber: json['trainee_phone_number'],
      status: json['trainee_status'],
      imagePath: json['image_path'],
      instructorEmail: json['instructor_email'],
      instructorFullName: json['instructor_full_name'],
      myDate: json['my_date'],
      traineeDesc: json['trainee_desc'],
    );
  }

  Map<String, dynamic> toJson() => {
        'class_type': classType,
        'trainee_full_name': fullName,
        'trainee_id': traineeId,
        'trainee_phone_number': phoneNumber,
        'trainee_status': status,
        'image_path': imagePath,
        'instructor_email': instructorEmail,
        'instructor_full_name': instructorFullName,
        'my_date': myDate,
        'trainee_desc': traineeDesc,
      };
}