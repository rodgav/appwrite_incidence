import 'dart:typed_data';

import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence/data/data_source/remote_data_source.dart';
import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/data/network/network_info.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/data/responses/area_response.dart';
import 'package:appwrite_incidence/data/responses/incidence_response.dart';
import 'package:appwrite_incidence/data/responses/name_response.dart';
import 'package:appwrite_incidence/data/responses/user_response.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo? _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, User>> account() async {
    try {
      final response = _localDataSource.getUser();
      return Right(response);
    } catch (cacheError) {
      if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
        try {
          final response = await _remoteDataSource.account();
          _localDataSource.saveUser(response);
          return Right(response);
        } on AppwriteException catch (e) {
          return Left(Failure(e.code ?? 0,
              e.message ?? 'Some thing went wrong, try again later'));
        } catch (error) {
          return Left(Failure(0, error.toString()));
        }
      } else {
        return Left(Failure(-7, 'Please check your internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, Session>> login(LoginRequest loginRequest) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        return Right(response);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, Token>> forgotPassword(String email) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        return Right(response);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteSession(String sessionId) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final res = await _remoteDataSource.deleteSession(sessionId);
        return Right(res);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Area>>> areas(int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.areas(limit, offset);
        final a = response.documents.map((e) => areaFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Area>>> areasSearch(
      String search, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.areasSearch(search, limit, offset);
        final a = response.documents.map((e) => areaFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, Area>> areaCreate(Area area) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.areaCreate(area);
        final a = areaFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, Area>> areaUpdate(Area area) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.areaUpdate(area);
        final a = areaFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidences(
      int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidences(limit, offset);
        final a =
            response.documents.map((e) => incidenceFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesArea(
      String areaId, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.incidencesArea(areaId, limit, offset);
        final a =
            response.documents.map((e) => incidenceFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaPriority(
      String areaId, String priority, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidencesAreaPriority(
            areaId, priority, limit, offset);
        final a =
            response.documents.map((e) => incidenceFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaPriorityActive(
      String areaId,
      bool active,
      String priority,
      int limit,
      int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidencesAreaPriorityActive(
            areaId, active, priority, limit, offset);
        final a =
            response.documents.map((e) => incidenceFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesSearch(
      String search, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.incidencesSearch(search, limit, offset);
        final a =
            response.documents.map((e) => incidenceFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, Incidence>> incidenceCreate(
      Incidence incidence) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidenceCreate(incidence);
        final a = incidenceFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, Incidence>> incidenceUpdate(
      Incidence incidence) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidenceUpdate(incidence);
        final a = incidenceFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> users(int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.users(limit, offset);
        final a = response.documents.map((e) => usersFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersTypeUser(
      String typeUser, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.usersTypeUser(typeUser, limit, offset);
        final a = response.documents.map((e) => usersFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersTypeUserArea(
      String typeUser, String areaId, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.usersTypeUserArea(
            typeUser, areaId, limit, offset);
        final a = response.documents.map((e) => usersFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersTypeUserAreaActive(
      String typeUser,
      String areaId,
      bool active,
      int limit,
      int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.usersTypeUserAreaActive(
            typeUser, areaId, active, limit, offset);
        final a = response.documents.map((e) => usersFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersSearch(
      String search, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.usersSearch(search, limit, offset);
        final a = response.documents.map((e) => usersFromJson(e.data)).toList();
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> userCreate(LoginRequest loginRequest,
      String area, bool active, String typeUser) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.userCreate(
            loginRequest, area, active, typeUser);
        final a = usersFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> userUpdate(UsersModel users) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.userUpdate(users);
        final a = usersFromJson(response.data);
        return Right(a);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Name>>> prioritys(int limit, int offset) async {
    try {
      final response = _localDataSource.getPrioritys();
      return Right(response);
    } catch (cacheError) {
      if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
        try {
          final response = await _remoteDataSource.prioritys(limit, offset);
          final a =
              response.documents.map((e) => nameFromJson(e.data)).toList();
          _localDataSource.savePrioritysToCache(a);
          return Right(a);
        } on AppwriteException catch (e) {
          return Left(Failure(e.code ?? 0,
              e.message ?? 'Some thing went wrong, try again later'));
        } catch (error) {
          return Left(Failure(0, error.toString()));
        }
      } else {
        return Left(Failure(-7, 'Please check your internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Name>>> typeUsers(int limit, int offset) async {
    try {
      final response = _localDataSource.getTypeUsers();
      return Right(response);
    } catch (cacheError) {
      if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
        try {
          final response = await _remoteDataSource.typeUsers(limit, offset);
          final a =
              response.documents.map((e) => nameFromJson(e.data)).toList();
          _localDataSource.saveTypeUsersToCache(a);
          return Right(a);
        } on AppwriteException catch (e) {
          return Left(Failure(e.code ?? 0,
              e.message ?? 'Some thing went wrong, try again later'));
        } catch (error) {
          return Left(Failure(0, error.toString()));
        }
      } else {
        return Left(Failure(-7, 'Please check your internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, File>> createFile(
      Uint8List uint8list, String name) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final res = await _remoteDataSource.createFile(uint8list, name);
        return Right(res);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteFile(String idFile) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final res = await _remoteDataSource.deleteFile(idFile);
        return Right(res);
      } on AppwriteException catch (e) {
        return Left(Failure(e.code ?? 0,
            e.message ?? 'Some thing went wrong, try again later'));
      } catch (error) {
        return Left(Failure(0, error.toString()));
      }
    } else {
      return Left(Failure(-7, 'Please check your internet connection'));
    }
  }
}
