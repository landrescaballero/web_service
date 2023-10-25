import "package:hive/hive.dart";
 

part "local_history.g.dart";

@HiveType(typeId: 1)
class LocalHistorial extends HiveObject{
  @HiveField(0)
  int id;  
  @HiveField(1)
  int time;  
  @HiveField(2)
  String email;  
  @HiveField(3)
  bool question1; 
  @HiveField(4)
  bool question2;  
  @HiveField(5)
  bool question3; 
  @HiveField(6)
  bool question4;  
  @HiveField(7)
  bool question5;
  @HiveField(8)
  bool question6;
  

  LocalHistorial({   
    required this.id,
    required this.time,
    required this.email,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
  });

  factory LocalHistorial.fromJson(Map<String, dynamic> json) => LocalHistorial(
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
        "id": id,
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