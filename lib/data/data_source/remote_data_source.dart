import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/network/app_api.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';

abstract class RemoteDataSource {
  Future<User> account();

  Future<Session> login(LoginRequest loginRequest);

  Future<Token> forgotPassword(String email);

  Future<dynamic> deleteSession(String sessionId);

  Future<DocumentList> areas(int limit, int offset);

  Future<DocumentList> areasSearch(String search, int limit, int offset);

  Future<Document> areaCreate(Area area);

  Future<Document> areaUpdate(Area area);

  Future<DocumentList> incidences(int limit, int offset);

  Future<DocumentList> incidencesArea(String areaId, int limit, int offset);

  Future<DocumentList> incidencesAreaPriority(
      String areaId, String priority, int limit, int offset);

  Future<DocumentList> incidencesAreaPriorityActive(
      String areaId, bool active, String priority, int limit, int offset);

  Future<DocumentList> incidencesSearch(String search, int limit, int offset);

  Future<Document> incidenceCreate(Incidence incidence);

  Future<Document> incidenceUpdate(Incidence incidence);

  Future<DocumentList> users(int limit, int offset);
  Future<DocumentList>  usersTypeUser(String typeUser, int limit, int offset);

  Future<DocumentList> usersTypeUserArea(
      String typeUser, String areaId, int limit, int offset);

  Future<DocumentList> usersTypeUserAreaActive(
      String typeUser, String areaId, bool active, int limit, int offset);

  Future<DocumentList> usersSearch(String search, int limit, int offset);

  Future<Document> userCreate(
      LoginRequest loginRequest, String area, bool active, String typeUser);

  Future<Document> userUpdate(UsersModel users);

  Future<DocumentList> prioritys(int limit, int offset);

  Future<DocumentList> typeUsers(int limit, int offset);

  Future<File> createFile(Uint8List uint8list,String name);

  Future<dynamic> deleteFile(String idFile);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<User> account() => _appServiceClient.account();

  @override
  Future<Session> login(LoginRequest loginRequest) =>
      _appServiceClient.login(loginRequest);

  @override
  Future<Token> forgotPassword(String email) =>
      _appServiceClient.forgotPassword(email);

  @override
  Future<dynamic> deleteSession(String sessionId) =>
      _appServiceClient.deleteSession(sessionId);

  @override
  Future<DocumentList> areas(int limit, int offset) =>
      _appServiceClient.areas(limit, offset);

  @override
  Future<DocumentList> areasSearch(String search, int limit, int offset) =>
      _appServiceClient.areasSearch(search, limit, offset);

  @override
  Future<Document> areaCreate(Area area) => _appServiceClient.areaCreate(area);

  @override
  Future<Document> areaUpdate(Area area) => _appServiceClient.areaUpdate(area);

  @override
  Future<DocumentList> incidences(int limit, int offset) =>
      _appServiceClient.incidences(limit, offset);

  @override
  Future<DocumentList> incidencesArea(String areaId, int limit, int offset) =>
      _appServiceClient.incidencesArea(areaId, limit, offset);

  @override
  Future<DocumentList> incidencesAreaPriority(
          String areaId, String priority, int limit, int offset) =>
      _appServiceClient.incidencesAreaPriority(areaId, priority, limit, offset);

  @override
  Future<DocumentList> incidencesAreaPriorityActive(
          String areaId, bool active, String priority, int limit, int offset) =>
      _appServiceClient.incidencesAreaPriorityActive(
          areaId, active, priority, limit, offset);

  @override
  Future<DocumentList> incidencesSearch(String search, int limit, int offset) =>
      _appServiceClient.incidencesSearch(search, limit, offset);

  @override
  Future<Document> incidenceCreate(Incidence incidence) =>
      _appServiceClient.incidenceCreate(incidence);

  @override
  Future<Document> incidenceUpdate(Incidence incidence) =>
      _appServiceClient.incidenceUpdate(incidence);

  @override
  Future<DocumentList> users( int limit, int offset) =>
      _appServiceClient.users( limit, offset);
  @override
  Future<DocumentList> usersTypeUser(String typeUser, int limit, int offset) =>
      _appServiceClient.usersTypeUser(typeUser, limit, offset);

  @override
  Future<DocumentList> usersTypeUserArea(
          String typeUser, String areaId, int limit, int offset) =>
      _appServiceClient.usersTypeUserArea(typeUser, areaId, limit, offset);

  @override
  Future<DocumentList> usersTypeUserAreaActive(
          String typeUser, String areaId, bool active, int limit, int offset) =>
      _appServiceClient.usersTypeUserAreaActive(
          typeUser, areaId, active, limit, offset);

  @override
  Future<DocumentList> usersSearch(String search, int limit, int offset) =>
      _appServiceClient.usersSearch(search, limit, offset);

  @override
  Future<Document> userCreate(LoginRequest loginRequest, String area,
          bool active, String typeUser) =>
      _appServiceClient.userCreate(loginRequest, area, active, typeUser);

  @override
  Future<Document> userUpdate(UsersModel users) =>
      _appServiceClient.userUpdate(users);

  @override
  Future<DocumentList> prioritys(int limit, int offset) =>
      _appServiceClient.prioritys(limit, offset);

  @override
  Future<DocumentList> typeUsers(int limit, int offset) =>
      _appServiceClient.typeUsers(limit, offset);

  @override
  Future<File> createFile(Uint8List uint8list,String name) =>
      _appServiceClient.createFile(uint8list,name);

  @override
  Future deleteFile(String idFile) => _appServiceClient.deleteFile(idFile);
}
