import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class AreasUseCase
    implements
        BaseUseCase<AreasUseCaseInput, List<Area>>,
        AreasUseCaseInputCreate<Area, Area>,
        AreasUseCaseInputUpdate<Area, Area> {
  final Repository _repository;

  AreasUseCase(this._repository);

  @override
  Future<Either<Failure, List<Area>>> execute(AreasUseCaseInput input) =>
      _repository.areas(input.limit, input.offset);

  @override
  Future<Either<Failure, Area>> areaCreate(Area area) =>
      _repository.areaCreate(area);

  @override
  Future<Either<Failure, Area>> areaUpdate(Area area) =>
      _repository.areaUpdate(area);
}

class AreasUseCaseInput {
  int limit, offset;

  AreasUseCaseInput(this.limit, this.offset);
}

abstract class AreasUseCaseInputCreate<In, Out> {
  Future<Either<Failure, Out>> areaCreate(In input);
}

abstract class AreasUseCaseInputUpdate<In, Out> {
  Future<Either<Failure, Out>> areaUpdate(In input);
}
