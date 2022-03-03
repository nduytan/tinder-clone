import 'dart:convert';

import 'package:flutter/cupertino.dart';

FullUserInfo userDetailFromJson(String str) =>
    FullUserInfo.fromJson(json.decode(str));

String userDetailToJson(FullUserInfo data) => json.encode(data.toJson());

class FullUserInfo {
  FullUserInfo({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
    this.age,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;
  String gender;
  String email;
  DateTime dateOfBirth;
  String phone;
  Location location;
  DateTime registerDate;
  DateTime updatedDate;
  int age;

  factory FullUserInfo.fromJson(Map<String, dynamic> json) => FullUserInfo(
      id: json["id"],
      title: json["title"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      picture: json["picture"],
      gender: json["gender"],
      email: json["email"],
      dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      phone: json["phone"],
      location: Location.fromJson(json["location"]),
      registerDate: DateTime.parse(json["registerDate"]),
      updatedDate: DateTime.parse(json["updatedDate"]),
      age: DateTime.now().year - DateTime.parse(json["dateOfBirth"]).year);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "gender": gender,
        "email": email,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "phone": phone,
        "location": location.toJson(),
        "registerDate": registerDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
      };
}

class Location {
  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  String street;
  String city;
  String state;
  String country;
  String timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "timezone": timezone,
      };
}
