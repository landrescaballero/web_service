class History {
  
  History({
    this.id,
    required this.time,
    required this.email,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
  });

  int? id;
  int time;
  String email;
  bool question1;
  bool question2;
  bool question3;
  bool question4;
  bool question5;
  bool question6;


  String get emailAddress => email;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        time: json["time"] ?? 1,
        email: json["email"] ?? "someemail@loco.com",
        question1: json["question1"]??false,
        question2: json["question2"]??false,
        question3: json["question3"]??false,
        question4: json["question4"]??false,
        question5: json["question5"]??false,
        question6: json["question6"]??false,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "email": email,
        "time":time,
        "question1": question1,
        "question2": question2,
        "question3": question3,
        "question4": question4,
        "question5": question5,
        "question6": question6,
      };
}
