import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String phone_number;

  @HiveField(3)
  late String address;
  @HiveField(4)
  String? token;
  @HiveField(5)
  String? lat;

  @HiveField(6)
  String? lang;
  UserModel(
      {required this.name,
      required this.email,
      required this.phone_number,
      required this.address,
      this.lat,
      this.lang,this.token});
  @override
  String toString() {
    return '{${this.name}, ${this.email}}';
  }
}
