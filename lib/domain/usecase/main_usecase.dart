import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:appwrite_incidence/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class MainUseCase
    implements
        BaseUseCase<MainUseCaseInput, List<Incidence>>,
        MainUseCaseAreas<MainUseCaseInput, List<Area>>,
        MainUseCaseUsers<MainUseCaseInput, List<UsersModel>>,
        MainUseCaseDeleteSession<MainDeleteSessionUseCaseInput, dynamic>,
        MainUseCaseAccount<String, UsersModel> {
  final Repository _repository;

  MainUseCase(this._repository);

  @override
  Future<Either<Failure, List<Incidence>>> execute(MainUseCaseInput input) =>
      _repository.incidencesSearch(input.search, input.limit, input.offset);

  @override
  Future<Either<Failure, List<Area>>> areas(MainUseCaseInput input) =>
      _repository.areasSearch(input.search, input.limit, input.offset);

  @override
  Future<Either<Failure, List<UsersModel>>> users(MainUseCaseInput input) =>
      _repository.usersSearch(input.search, input.limit, input.offset);

  @override
  Future<Either<Failure, dynamic>> deleteSession(
          MainDeleteSessionUseCaseInput input) =>
      _repository.deleteSession(input.sessionId);

  @override
  Future<Either<Failure, UsersModel>> user(String userId) =>
      _repository.user(userId);
}

class MainUseCaseInput {
  String search;
  int limit, offset;

  MainUseCaseInput(this.search, this.limit, this.offset);
}

class MainDeleteSessionUseCaseInput {
  String sessionId;

  MainDeleteSessionUseCaseInput(this.sessionId);
}

abstract class MainUseCaseAreas<In, Out> {
  Future<Either<Failure, Out>> areas(In input);
}

abstract class MainUseCaseUsers<In, Out> {
  Future<Either<Failure, Out>> users(In input);
}

abstract class MainUseCaseDeleteSession<In, Out> {
  Future<Either<Failure, Out>> deleteSession(In input);
}

abstract class MainUseCaseAccount<In, Out> {
  Future<Either<Failure, Out>> user(In input);
}
