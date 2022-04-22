import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/usecase/incidences_usecase.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class IncidencesViewModel extends BaseViewModel
    with IncidencesViewModelInputs, IncidencesViewModelOutputs {
  final IncidencesUseCase _incidencesUseCase;
  final AppPreferences _appPreferences;

  IncidencesViewModel(this._incidencesUseCase, this._appPreferences);

  final _incidencesStrCtrl = BehaviorSubject<List<Incidence>>();
  final _isLoading = BehaviorSubject<bool>();
  final List<Incidence> _incidences = [];

  @override
  Sink get inputIncidences => _incidencesStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Stream<List<Incidence>> get outputIncidences =>
      _incidencesStrCtrl.stream.map((incidences) => incidences);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  incidences() async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase
              .execute(IncidencesUseCaseInput(limit: 25, offset: 0)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              limit: 25, offset: _incidences.length - 1)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesArea() async {
    _incidences.clear();
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.execute(
              IncidencesUseCaseInput(areaId: '', limit: 25, offset: 0)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              areaId: '', limit: 25, offset: _incidences.length - 1)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesAreaActive() async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              active: true, areaId: '', limit: 25, offset: 0)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              active: true,
              areaId: '',
              limit: 25,
              offset: _incidences.length - 1)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesAreaActiveTypeReport(String typeReport) async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              active: true,
              typeReport: typeReport,
              areaId: '',
              limit: 25,
              offset: 0)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              active: true,
              typeReport: typeReport,
              areaId: '',
              limit: 25,
              offset: _incidences.length - 1)))
          .fold((l) {}, (areas) {
        _incidences.addAll(areas);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }
}

abstract class IncidencesViewModelInputs {
  Sink get inputIncidences;

  Sink get inputIsLoading;

  incidences();

  incidencesArea();

  incidencesAreaActive();

  incidencesAreaActiveTypeReport(String typeReport);

  changeIsLoading(bool isLoading);
}

abstract class IncidencesViewModelOutputs {
  Stream<List<Incidence>> get outputIncidences;

  Stream<bool> get outputIsLoading;
}
