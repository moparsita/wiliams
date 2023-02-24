
class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.mobile,
    required this.personalCode,
    required this.address,
    required this.avatar,

  });

  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String mobile;
  final String personalCode;
  final String address;
  String avatar;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],

        fullName: json["fullName"],
        mobile: json["mobile"],
        personalCode: json["personalCode"],
        address: json["address"],
        avatar: json["avatar"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,

        "fullName": fullName,
        "mobile": mobile,
        "personalCode": personalCode,
        "address": address,
        "avatar": avatar,

      };
}
