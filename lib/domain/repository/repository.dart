import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, User>> account();

  Future<Either<Failure, Session>> login(LoginRequest loginRequest);

  Future<Either<Failure, Token>> forgotPassword(String email);

  Future<Either<Failure, dynamic>> deleteSession(String sessionId);

  Future<Either<Failure, List<Area>>> areas(int limit, int offset);

  Future<Either<Failure, List<Area>>> areasSearch(
      String search, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidences(int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesArea(
      String areaId, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesAreaPriority(
      String areaId, String priority, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesAreaPriorityActive(
      String areaId, bool active, String priority, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesSearch(
      String search, int limit, int offset);

  Future<Either<Failure, List<Users>>> users(
      String typeUser, int limit, int offset);

  Future<Either<Failure, List<Users>>> usersArea(
      String typeUser, String areaId, int limit, int offset);

  Future<Either<Failure, List<Users>>> usersAreaActive(
      String typeUser, String areaId, bool active, int limit, int offset);

  Future<Either<Failure, List<Users>>> usersSearch(
      String typeUser, String search, int limit, int offset);

  Future<Either<Failure, List<Name>>> prioritys(int limit, int offset);

  Future<Either<Failure, List<Name>>> typeUsers(int limit, int offset);
}
