import 'package:appwrite_incidence/data/network/failure.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class IncidencesUseCase
    implements
        BaseUseCase<IncidencesUseCaseInput, List<Incidence>>,
        IncidencesUseCaseArea<IncidencesUseCaseInput, List<Incidence>>,
        IncidencesUseCaseAreaActive<IncidencesUseCaseInput,
            List<Incidence>>,
        IncidencesUseCaseAreaActiveTypeReport<IncidencesUseCaseInput,
            List<Incidence>> {
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
        input.areaId, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaActive(
      IncidencesUseCaseInput input) async {
    return await _repository.incidencesAreaActive(
        input.areaId, input.active, input.limit, input.offset);
  }

  @override
  Future<Either<Failure, List<Incidence>>> incidencesAreaActiveTypeReport(
      IncidencesUseCaseInput input) async {
    return await _repository.incidencesAreaActiveTypeReport(input.areaId,
        input.active, input.typeReport, input.limit, input.offset);
  }
}

class IncidencesUseCaseInput {
  bool active;
  String typeReport, areaId;
  int limit, offset;

  IncidencesUseCaseInput(
      {this.active = true,
      this.typeReport = '',
      this.areaId = '',
      required this.limit,
      required this.offset});
}

abstract class IncidencesUseCaseArea<In, Out> {
  Future<Either<Failure, Out>> incidencesArea(In input);
}

abstract class IncidencesUseCaseAreaActive<In, Out> {
  Future<Either<Failure, Out>> incidencesAreaActive(In input);
}

abstract class IncidencesUseCaseAreaActiveTypeReport<In, Out> {
  Future<Either<Failure, Out>> incidencesAreaActiveTypeReport(In input);
}
