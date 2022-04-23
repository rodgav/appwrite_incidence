import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class UsersUseCase
    implements
        BaseUseCase<UsersUseCaseInput, List<Users>>,
        UsersUseCaseArea<UsersUseCaseInput, List<Users>>,
        UsersUseCaseAreaActive<UsersUseCaseInput, List<Users>>,
        UsersUseCaseAreas<void, List<Area>>,
        UsersUseCaseTypeUsers<void, List<Name>> {
  final Repository _repository;

  UsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<Users>>> execute(UsersUseCaseInput input) async {
    return await _repository.users(input.typeUser, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Users>>> usersArea(
      UsersUseCaseInput input) async {
    return await _repository.usersArea(
        input.typeUser, input.area, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Users>>> usersAreaActive(
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
