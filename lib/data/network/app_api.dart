import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/app/constants.dart';
import 'package:appwrite_incidence/data/request/request.dart';

class AppServiceClient {
  late final Account _account;
  late final Database _database;

  AppServiceClient(Client _client)
      : _account = Account(_client),
        _database = Database(_client);

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

  Future<DocumentList> incidences(int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId, limit: limit, offset: offset);

  Future<DocumentList> incidencesArea(String areaId, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [Query.equal('area_id', areaId)],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesAreaActive(
          String areaId, bool active, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [
            Query.equal('area_id', areaId),
            Query.equal('active', active)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesAreaActiveTypeReport(String areaId,
          bool active, String typeReport, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [
            Query.equal('area_id', areaId),
            Query.equal('active', active),
            Query.equal('type_report', typeReport)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> incidencesSearch(String search, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: [Query.search('name', search)],
          limit: limit,
          offset: offset);

  Future<DocumentList> users(String typeUser, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [Query.equal('type_user', typeUser)],
          limit: limit,
          offset: offset);

  Future<DocumentList> usersArea(
          String typeUser, String areaId, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [
            Query.equal('type_user', typeUser),
            Query.equal('area_id', areaId)
          ],
          limit: limit,
          offset: offset);

  Future<DocumentList> usersAreaActive(
          String typeUser, String areaId, bool active, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.usersId,
          queries: [
            Query.equal('type_user', typeUser),
            Query.equal('area_id', areaId),
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
}
