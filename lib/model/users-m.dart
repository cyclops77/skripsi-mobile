// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

List<UsersModel> usersModelFromJson(List str) =>
    List<UsersModel>.from(str.map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
    this.id,
    this.privileges,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.survey,
  });

  int id;
  String privileges;
  String firstName;
  String lastName;
  String username;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  List<Survey> survey;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"] == null ? null : json["id"],
        privileges: json["privileges"] == null ? null : json["privileges"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        survey: json["survey"] == null
            ? null
            : List<Survey>.from(json["survey"].map((x) => Survey.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "privileges": privileges == null ? null : privileges,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "survey": survey == null
            ? null
            : List<dynamic>.from(survey.map((x) => x.toJson())),
      };
}

class Survey {
  Survey({
    this.id,
    this.userId,
    this.nama,
    this.alamat,
    this.tanggal,
    this.status,
    this.penghasilan,
    this.kualitasDinding,
    this.kualitasLantai,
    this.kualitasAtap,
    this.pendidikanAnak,
    this.output,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String nama;
  String alamat;
  DateTime tanggal;
  String status;
  String penghasilan;
  String kualitasDinding;
  String kualitasLantai;
  String kualitasAtap;
  String pendidikanAnak;
  String output;
  DateTime createdAt;
  DateTime updatedAt;

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        nama: json["nama"] == null ? null : json["nama"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        status: json["status"] == null ? null : json["status"],
        penghasilan: json["penghasilan"] == null ? null : json["penghasilan"],
        kualitasDinding:
            json["kualitasDinding"] == null ? null : json["kualitasDinding"],
        kualitasLantai:
            json["kualitasLantai"] == null ? null : json["kualitasLantai"],
        kualitasAtap:
            json["kualitasAtap"] == null ? null : json["kualitasAtap"],
        pendidikanAnak:
            json["pendidikanAnak"] == null ? null : json["pendidikanAnak"],
        output: json["output"] == null ? null : json["output"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "nama": nama == null ? null : nama,
        "alamat": alamat == null ? null : alamat,
        "tanggal": tanggal == null
            ? null
            : "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "penghasilan": penghasilan == null ? null : penghasilan,
        "kualitasDinding": kualitasDinding == null ? null : kualitasDinding,
        "kualitasLantai": kualitasLantai == null ? null : kualitasLantai,
        "kualitasAtap": kualitasAtap == null ? null : kualitasAtap,
        "pendidikanAnak": pendidikanAnak == null ? null : pendidikanAnak,
        "output": output == null ? null : output,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
