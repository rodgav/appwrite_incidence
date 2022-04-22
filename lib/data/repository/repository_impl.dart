import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence/data/data_source/remote_data_source.dart';
import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/data/network/network_info.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/data/responses/area_response.dart';
import 'package:appwrite_incidence/data/responses/incidence_response.dart';
import 'package:appwrite_incidence/data/responses/user_response.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
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
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.account();
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
  Future<Either<Failure, List<Incidence>>> incidencesAreaActive(
      String areaId, bool active, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidencesAreaActive(
            areaId, active, limit, offset);
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
  Future<Either<Failure, List<Incidence>>> incidencesAreaActiveTypeReport(
      String areaId,
      bool active,
      String typeReport,
      int limit,
      int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.incidencesAreaActiveTypeReport(
            areaId, active, typeReport, limit, offset);
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
  Future<Either<Failure, List<Users>>> users(
      String typeUser, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.users(typeUser, limit, offset);
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
  Future<Either<Failure, List<Users>>> usersArea(
      String typeUser, String areaId, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response =
            await _remoteDataSource.usersArea(typeUser, areaId, limit, offset);
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
  Future<Either<Failure, List<Users>>> usersAreaActive(String typeUser,
      String areaId, bool active, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.usersAreaActive(
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
  Future<Either<Failure, List<Users>>> usersSearch(
      String typeUser, String search, int limit, int offset) async {
    if (kIsWeb ? true : (await _networkInfo?.isConnected ?? false)) {
      try {
        final response = await _remoteDataSource.usersSearch(
            typeUser, search, limit, offset);
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
}
