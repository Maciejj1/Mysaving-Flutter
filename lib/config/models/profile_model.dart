class UserProfile {
  int id;
  String pictureImage;
  String name;
  String password;
  String email;
  String dateOfBirth;

  UserProfile(
      {required this.pictureImage,
      required this.name,
      required this.password,
      required this.email,
      required this.dateOfBirth,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pictureImage': pictureImage,
      'name': name,
      'password': password,
      'email': email,
      'dateOfBirth': dateOfBirth
    };
  }
}
