import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/app/constants.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/data/responses/area_response.dart';
import 'package:appwrite_incidence/data/responses/incidence_response.dart';
import 'package:appwrite_incidence/data/responses/user_response.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';

class AppServiceClient {
  final Account _account;
  final Database _database;
  final Storage _storage;

  AppServiceClient(Client _client, AppPreferences _appPreferences)
      : _account = Account(_client),
        _database = Database(_client),
        _storage = Storage(_client);

  Future<User> account() => _account.get();

  Future<Session> login(LoginRequest loginRequest) => _account.createSession(
      email: loginRequest.email, password: loginRequest.password);

  Future<Token> forgotPassword(String email) =>
      _account.createRecovery(email: email, url: Constant.baseUrl);

  Future<dynamic> deleteSession(String sessionId) =>
      _account.deleteSession(sessionId: sessionId);

  Future<DocumentList> areas(int limit, int offset) => _database.listDocuments(
      collectionId: Constant.areasId, limit: limit, offset: offset);

  Future<DocumentList> areasSearch(String search, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.areasId,
          queries: [Query.search('name', search)],
          limit: limit,
          offset: offset);

  Future<Document> areaCreate(Area area) => _database.createDocument(
      collectionId: Constant.areasId,
      documentId: 'unique()',
      data: areaToJson(area),
      read: ['role:member'],
      write: ['role:member']);

  Future<Document> areaUpdate(Area area) => _database.updateDocument(
      collectionId: Constant.areasId,
      documentId: area.id,
      data: areaToJson(area));

  Future<DocumentList> incidences(int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId, limit: limit, offset: offset);

  Future<DocumentList> incidencesArea(String area, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [Query.equal('area', area)],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesAreaPriority(
          String area, String priority, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [
            Query.equal('area', area),
            Query.equal('priority', priority)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesAreaPriorityActive(
          String area, bool active, String priority, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [
            Query.equal('area', area),
            Query.equal('priority', priority),
            Query.equal('active', active)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesSearch(String search, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [Query.search('name', search)],
          limit: limit,
          offset: offset);

  Future<Document> incidenceCreate(Incidence incidence) =>
      _database.createDocument(
          collectionId: Constant.incidencesId,
          documentId: 'unique()',
          data: incidenceToJson(incidence),
          read: ['role:member'],
          write: ['role:member']);

  Future<Document> incidenceUpdate(Incidence incidence) =>
      _database.updateDocument(
          collectionId: Constant.incidencesId,
          documentId: incidence.id,
          data: incidenceToJson(incidence));

  Future<DocumentList> users(String typeUser, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [Query.equal('type_user', typeUser)],
          limit: limit,
          offset: offset);

  Future<DocumentList> usersArea(
          String typeUser, String area, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [
            Query.equal('type_user', typeUser),
            Query.equal('area', area)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> usersAreaActive(
          String typeUser, String area, bool active, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [
            Query.equal('type_user', typeUser),
            Query.equal('area', area),
            Query.equal('active', active)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> usersSearch(
          String typeUser, String search, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [
            Query.search('name', search),
            Query.equal('type_user', typeUser)
          ],
          limit: limit,
          offset: offset);

  Future<Document> userCreate(LoginRequest loginRequest, String area,
      bool active, String typeUser) async {
    final user = await _account.create(
        userId: 'unique()',
        email: loginRequest.email,
        password: loginRequest.password,
        name: loginRequest.name);
    return _database.createDocument(
        collectionId: Constant.usersId,
        documentId: user.$id,
        data: {
          'name': user.name,
          'area': area,
          'active': active,
          'type_user': typeUser
        },
        read: [
          'role:member'
        ],
        write: [
          'role:member'
        ]);
  }

  Future<Document> userUpdate(UsersModel users) => _database.updateDocument(
      collectionId: Constant.usersId,
      documentId: users.id,
      data: usersToJson(users));

  Future<DocumentList> prioritys(int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.prioritysId, limit: limit, offset: offset);

  Future<DocumentList> typeUsers(int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.typeUsersId, limit: limit, offset: offset);

  Future<File> createFile(Uint8List uint8list) => _storage.createFile(
      bucketId: Constant.buckedId,
      fileId: 'unique()',
      file: InputFile(file: MultipartFile.fromBytes('file', uint8list)),
      read: ['role:member'],
      write: ['role:member']);

  Future deleteFile(String idFile) =>
      _storage.deleteFile(bucketId: Constant.buckedId, fileId: idFile);

}
