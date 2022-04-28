import 'dart:typed_data';

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

  Future<Either<Failure, Area>> areaCreate(Area area);

  Future<Either<Failure, Area>> areaUpdate(Area area);

  Future<Either<Failure, List<Incidence>>> incidences(int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesArea(
      String areaId, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesAreaPriority(
      String areaId, String priority, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesAreaPriorityActive(
      String areaId, bool active, String priority, int limit, int offset);

  Future<Either<Failure, List<Incidence>>> incidencesSearch(
      String search, int limit, int offset);

  Future<Either<Failure, Incidence>> incidenceCreate(
      Incidence incidence);

  Future<Either<Failure, Incidence>> incidenceUpdate(Incidence incidence);

  Future<Either<Failure, List<UsersModel>>> users( int limit, int offset);
  Future<Either<Failure, List<UsersModel>>> usersTypeUser(
      String typeUser, int limit, int offset);

  Future<Either<Failure, List<UsersModel>>> usersTypeUserArea(
      String typeUser, String areaId, int limit, int offset);

  Future<Either<Failure, List<UsersModel>>> usersTypeUserAreaActive(
      String typeUser, String areaId, bool active, int limit, int offset);

  Future<Either<Failure, List<UsersModel>>> usersSearch( String search, int limit, int offset);

  Future<Either<Failure, UsersModel>> userCreate(
      LoginRequest loginRequest, String area, bool active, String typeUser);

  Future<Either<Failure, UsersModel>> userUpdate(UsersModel users);

  Future<Either<Failure, List<Name>>> prioritys(int limit, int offset);

  Future<Either<Failure, List<Name>>> typeUsers(int limit, int offset);

  Future<Either<Failure,File>> createFile(Uint8List uint8list,String name);

  Future<Either<Failure,dynamic>> deleteFile(String idFile);

}
