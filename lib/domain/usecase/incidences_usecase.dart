import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class IncidencesUseCase
    implements
        BaseUseCase<IncidencesUseCaseInput, List<Incidence>>,
        IncidencesUseCaseArea<IncidencesUseCaseInput, List<Incidence>>,
        IncidencesUseCaseAreaActive<IncidencesUseCaseInput, List<Incidence>>,
        IncidencesUseCaseAreaActiveTypeReport<IncidencesUseCaseInput,
            List<Incidence>>,
        IncidencesUseCasePrioritys<void, List<Name>>,
        IncidencesUseCaseAreas<void, List<Area>> {
  final Repository _repository;

  IncidencesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Incidence>>> execute(
      IncidencesUseCaseInput input) async {
    return await _repository.incidences(input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesArea(
      IncidencesUseCaseInput input) async {
    return await _repository.incidencesArea(
        input.area, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaPriority(
      IncidencesUseCaseInput input) async {
    return await _repository.incidencesAreaPriority(
        input.area, input.priority, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaPriorityActive(
      IncidencesUseCaseInput input) async {
    return await _repository.incidencesAreaPriorityActive(
        input.area, input.active, input.priority, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Name>>> prioritys(void input) =>
      _repository.prioritys(25, 0);

  @override
  Future<Either<Failure, List<Area>>> areas(void input) =>
      _repository.areas(25, 0);
}

class IncidencesUseCaseInput {
  bool active;
  String priority, area;
  int limit, offset;

  IncidencesUseCaseInput(
      {this.active = true,
      this.priority = '',
      this.area = '',
      required this.limit,
      required this.offset});
}

abstract class IncidencesUseCaseArea<In, Out> {
  Future<Either<Failure, Out>> incidencesArea(In input);
}

abstract class IncidencesUseCaseAreaActive<In, Out> {
  Future<Either<Failure, Out>> incidencesAreaPriority(In input);
}

abstract class IncidencesUseCaseAreaActiveTypeReport<In, Out> {
  Future<Either<Failure, Out>> incidencesAreaPriorityActive(In input);
}

abstract class IncidencesUseCasePrioritys<In, Out> {
  Future<Either<Failure, Out>> prioritys(In input);
}

abstract class IncidencesUseCaseAreas<In, Out> {
  Future<Either<Failure, Out>> areas(In input);
}
