import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0)
  String firstName = "";
  @HiveField(1)
  String lastName = "";
  @HiveField(2)
  String sex = "";
  @HiveField(3)
  String email = "";
  @HiveField(4)
  String password = "";
  @HiveField(5)
  String faculte = "";
  @HiveField(6)
  String department = "";
  @HiveField(7)
  String specialist = "";
  @HiveField(8)
  String year = "";

  Student({required this.firstName,required this.lastName,required this.sex,required this.specialist,required this.department,required this.faculte,required this.password,required this.email,required this.year});
}
