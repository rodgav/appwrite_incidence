import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class UsersUseCase
    implements
        BaseUseCase<UsersUseCaseInput, List<UsersModel>>,
        UsersUseCaseArea<UsersUseCaseInput, List<UsersModel>>,
        UsersUseCaseAreaActive<UsersUseCaseInput, List<UsersModel>>,
        UsersUseCaseAreas<void, List<Area>>,
        UsersUseCaseTypeUsers<void, List<Name>>,
        UsersUseCaseUserCreate<UsersCreateUseCaseInput, UsersModel>,
        UsersUseCaseUserUpdate<UsersModel, UsersModel> {
  final Repository _repository;

  UsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<UsersModel>>> execute(UsersUseCaseInput input) async {
    return await _repository.users(input.typeUser, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersArea(
      UsersUseCaseInput input) async {
    return await _repository.usersArea(
        input.typeUser, input.area, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<UsersModel>>> usersAreaActive(
      UsersUseCaseInput input) async {
    return await _repository.usersAreaActive(
        input.typeUser, input.area, input.active, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Area>>> areas(void input) =>
      _repository.areas(25, 0);

  @override
  Future<Either<Failure, List<Name>>> typeUsers(void input) =>
      _repository.typeUsers(25, 0);

  @override
  Future<Either<Failure, UsersModel>> userCreate(UsersCreateUseCaseInput input) =>
      _repository.userCreate(input.loginRequest, input.area,input.active, input.typeUser);

  @override
  Future<Either<Failure, UsersModel>> userUpdate(UsersModel users) =>
      _repository.userUpdate(users);
}

class UsersUseCaseInput {
  bool active;
  String typeUser, area;
  int limit, offset;

  UsersUseCaseInput(
      {this.active = true,
      required this.typeUser,
      this.area = '',
      required this.limit,
      required this.offset});
}

class UsersCreateUseCaseInput {
  LoginRequest loginRequest;
  bool active;
  String typeUser, area;

  UsersCreateUseCaseInput(
      this.loginRequest, this.active, this.typeUser, this.area);
}

abstract class UsersUseCaseArea<In, Out> {
  Future<Either<Failure, Out>> usersArea(In input);
}

abstract class UsersUseCaseAreaActive<In, Out> {
  Future<Either<Failure, Out>> usersAreaActive(In input);
}

abstract class UsersUseCaseAreas<In, Out> {
  Future<Either<Failure, Out>> areas(In input);
}

abstract class UsersUseCaseTypeUsers<In, Out> {
  Future<Either<Failure, Out>> typeUsers(In input);
}

abstract class UsersUseCaseUserCreate<In, Out> {
  Future<Either<Failure, Out>> userCreate(In input);
}

abstract class UsersUseCaseUserUpdate<In, Out> {
  Future<Either<Failure, Out>> userUpdate(In input);
}
