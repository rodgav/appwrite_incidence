import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class UsersUseCase
    implements
        BaseUseCase<UsersUseCaseInput, List<Users>>,
        UsersUseCaseArea<UsersUseCaseInput, List<Users>>,
        UsersUseCaseAreaActive<UsersUseCaseInput, List<Users>> {
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
        input.typeUser, input.areaId, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Users>>> usersAreaActive(
      UsersUseCaseInput input) async {
    return await _repository.usersAreaActive(
        input.typeUser, input.areaId, input.active, input.limit, input.offset);
  }
}

class UsersUseCaseInput {
  bool active;
  String typeUser, areaId;
  int limit, offset;

  UsersUseCaseInput(
      {this.active = true,
      required this.typeUser,
      this.areaId = '',
      required this.limit,
      required this.offset});
}

abstract class UsersUseCaseArea<In, Out> {
  Future<Either<Failure, Out>> usersArea(In input);
}

abstract class UsersUseCaseAreaActive<In, Out> {
  Future<Either<Failure, Out>> usersAreaActive(In input);
}
