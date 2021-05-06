// To parse this JSON data, do
//
//     final currentSurveyModel = currentSurveyModelFromJson(jsonString);

import 'dart:convert';

List<CurrentSurveyModel> currentSurveyModelFromJson(List str) =>
    List<CurrentSurveyModel>.from(
        str.map((x) => CurrentSurveyModel.fromJson(x)));

String currentSurveyModelToJson(List<CurrentSurveyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentSurveyModel {
  CurrentSurveyModel({
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
  dynamic penghasilan;
  dynamic kualitasDinding;
  dynamic kualitasLantai;
  dynamic kualitasAtap;
  dynamic pendidikanAnak;
  dynamic output;
  DateTime createdAt;
  DateTime updatedAt;

  factory CurrentSurveyModel.fromJson(Map<String, dynamic> json) =>
      CurrentSurveyModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        nama: json["nama"] == null ? null : json["nama"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        status: json["status"] == null ? null : json["status"],
        penghasilan: json["penghasilan"],
        kualitasDinding: json["kualitasDinding"],
        kualitasLantai: json["kualitasLantai"],
        kualitasAtap: json["kualitasAtap"],
        pendidikanAnak: json["pendidikanAnak"],
        output: json["output"],
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
        "penghasilan": penghasilan,
        "kualitasDinding": kualitasDinding,
        "kualitasLantai": kualitasLantai,
        "kualitasAtap": kualitasAtap,
        "pendidikanAnak": pendidikanAnak,
        "output": output,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
