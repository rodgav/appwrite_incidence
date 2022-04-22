import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Session> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Session>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email, password;

  LoginUseCaseInput(this.email, this.password);
}
