// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'package:appwrite_incidence/domain/model/user_model.dart';

Users usersFromString(String str) => usersFromJson(json.decode(str));

String usersToString(Users data) => json.encode(usersToJson(data));

Users usersFromJson(Map<String, dynamic> json) => Users(
      name: json["name"],
      areaId: json["area_id"],
      active: json["active"],
      typeUser: json["type_user"],
      read: List<String>.from(json["\u0024read"].map((x) => x)),
      write: List<String>.from(json["\u0024write"].map((x) => x)),
      id: json["\u0024id"],
      collection: json["\u0024collection"],
    );

Map<String, dynamic> usersToJson(Users users) => {
      "name": users.name,
      "area_id": users.areaId,
      "active": users.active,
      "type_user": users.typeUser,
      "\u0024read": List<dynamic>.from(users.read.map((x) => x)),
      "\u0024write": List<dynamic>.from(users.write.map((x) => x)),
      "\u0024id": users.id,
      "\u0024collection": users.collection,
    };
