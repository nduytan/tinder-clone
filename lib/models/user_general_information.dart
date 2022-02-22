import 'dart:convert';

UserGeneralInformation userGeneralInformationFromJson(String str) =>
    UserGeneralInformation.fromJson(json.decode(str));

String userGeneralInformationToJson(UserGeneralInformation data) =>
    json.encode(data.toJson());

class UserGeneralInformation {
  UserGeneralInformation({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  factory UserGeneralInformation.fromJson(Map<String, dynamic> json) =>
      UserGeneralInformation(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
      };
}
