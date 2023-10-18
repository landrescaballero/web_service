class User {
  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.course,
    required this.password,
  });

  int? id;
  String email;
  String firstName;
  String lastName;
  String birthday;
  int course;
  String password;

  String get name => '$firstName $lastName';

  String get emailAddress => email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstname"] ?? "augusto",
        lastName: json["lastname"] ?? "elmejorprofesor",
        email: json["email"] ?? "someemail@loco.com",
        birthday: json["birthday"] ?? "Aug 21, 1932 8:27 AM",
        course: json["course"] ?? 1,
        password: json["password"] ?? "123456",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "email": email,
        "course": course,
        "birthday": birthday,
        "lastname": lastName,
        "password": password,
        "firstname": firstName,
      };
}
