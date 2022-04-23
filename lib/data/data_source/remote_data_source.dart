import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/network/app_api.dart';
import 'package:appwrite_incidence/data/request/request.dart';

abstract class RemoteDataSource {
  Future<User> account();

  Future<Session> login(LoginRequest loginRequest);

  Future<Token> forgotPassword(String email);

  Future<dynamic> deleteSession(String sessionId);

  Future<DocumentList> areas(int limit, int offset);

  Future<DocumentList> areasSearch(String search, int limit, int offset);

  Future<DocumentList> incidences(int limit, int offset);

  Future<DocumentList> incidencesArea(String areaId, int limit, int offset);

  Future<DocumentList> incidencesAreaPriority(String areaId, String priority,
      int limit, int offset);

  Future<DocumentList> incidencesAreaPriorityActive(String areaId,
      bool active, String priority, int limit, int offset);

  Future<DocumentList> incidencesSearch(String search, int limit, int offset);

  Future<DocumentList> users(String typeUser, int limit, int offset);

  Future<DocumentList> usersArea(String typeUser, String areaId, int limit,
      int offset);

  Future<DocumentList> usersAreaActive(String typeUser, String areaId,
      bool active, int limit, int offset);

  Future<DocumentList> usersSearch(String typeUser, String search, int limit,
      int offset);

  Future<DocumentList> prioritys(int limit, int offset);

  Future<DocumentList> typeUsers(int limit, int offset);
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
  Future<DocumentList> incidences(int limit, int offset) =>
      _appServiceClient.incidences(limit, offset);

  @override
  Future<DocumentList> incidencesArea(String areaId, int limit, int offset) =>
      _appServiceClient.incidencesArea(areaId, limit, offset);

  @override
  Future<DocumentList> incidencesAreaPriority(String areaId, String priority,
      int limit, int offset) =>
      _appServiceClient.incidencesAreaPriority(areaId, priority, limit, offset);

  @override
  Future<DocumentList> incidencesAreaPriorityActive(String areaId,
      bool active, String priority, int limit, int offset) =>
      _appServiceClient.incidencesAreaPriorityActive(
          areaId, active, priority, limit, offset);

  @override
  Future<DocumentList> incidencesSearch(String search, int limit, int offset) =>
      _appServiceClient.incidencesSearch(search, limit, offset);

  @override
  Future<DocumentList> users(String typeUser, int limit, int offset) =>
      _appServiceClient.users(typeUser, limit, offset);

  @override
  Future<DocumentList> usersArea(String typeUser, String areaId, int limit,
      int offset) =>
      _appServiceClient.usersArea(typeUser, areaId, limit, offset);

  @override
  Future<DocumentList> usersAreaActive(String typeUser, String areaId,
      bool active, int limit, int offset) =>
      _appServiceClient.usersAreaActive(
          typeUser, areaId, active, limit, offset);

  @override
  Future<DocumentList> usersSearch(String typeUser, String search, int limit,
      int offset) =>
      _appServiceClient.usersSearch(typeUser, search, limit, offset);

  @override
  Future<DocumentList> prioritys(int limit, int offset) =>
      _appServiceClient.prioritys(limit, offset);

  @override
  Future<DocumentList> typeUsers(int limit, int offset) =>
      _appServiceClient.typeUsers(limit, offset);
}
