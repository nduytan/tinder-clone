import 'dart:convert';

BasicUserInfo userGeneralInformationFromJson(String str) =>
    BasicUserInfo.fromJson(json.decode(str));

String userGeneralInformationToJson(BasicUserInfo data) =>
    json.encode(data.toJson());

class BasicUserInfo {
  BasicUserInfo({
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

  factory BasicUserInfo.fromJson(Map<String, dynamic> json) => BasicUserInfo(
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
