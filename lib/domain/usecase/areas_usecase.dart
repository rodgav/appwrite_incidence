import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class AreasUseCase implements BaseUseCase<AreasUseCaseInput, List<Area>> {
  final Repository _repository;

  AreasUseCase(this._repository);

  @override
  Future<Either<Failure, List<Area>>> execute(AreasUseCaseInput input) async {
    return await _repository.areas(input.limit, input.offset);
  }
}

class AreasUseCaseInput {
  int limit, offset;

  AreasUseCaseInput(this.limit, this.offset);
}
