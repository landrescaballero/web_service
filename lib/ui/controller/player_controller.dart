import 'package:get/get.dart';

class PlayerController extends GetxController {
  RxInt id = 0.obs;
  RxInt difficult = 1.obs;
  RxString email = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString birthday = "".obs;
  RxString course = "".obs;
  RxString password = "".obs;
  RxString school = "".obs;

  setValues(Map<String, dynamic> data) {
    int id = data['id'];
    String diff = data['diff'].toString();
    String email = data['email'].toString();
    String course = data['course'].toString();
    String birthday = data['birthday'].toString();
    String lastname = data['lastname'].toString();
    String password = data['password'].toString();
    String firstname = data['firstname'].toString();
    String school = data['school'].toString();
    this.id.value = id;
    difficult.value = int.parse(diff);
    this.email.value = email;
    this.course.value = course;
    this.birthday.value = birthday;
    lastName.value = lastname;
    this.password.value = password;
    firstName.value = firstname;
    this.school.value = school;
  }

  updateDifficult(int diff) {
    difficult.value = diff;
  }
}
