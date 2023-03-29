
class Student {
  static String firstName = "";
  static String lastName = "";
  static String sex = "";
  static String email = "";
  static String password = "";
  static String faculte = "";
  static String department = "";
  static String specialist = "";
  static String year = "";

 static dynamic setstudent(String f, String l, String s, String e, String p,
      String fa, String d, String sp, String y) {
    firstName = f;
    lastName = l;
    sex = s;
    email = e;
    password = p;
    faculte = fa;
    department = d;
    specialist = sp;
    year = y;
  }

 static dynamic getstudent() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "sex": sex,
      "email": email,
      "password": password,
      "faculte": faculte,
      "department": department,
      "specialist": specialist,
      "year": year
    };
  }
}
