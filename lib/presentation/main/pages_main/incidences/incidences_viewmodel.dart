import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/usecase/incidences_usecase.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class IncidencesViewModel extends BaseViewModel
    with IncidencesViewModelInputs, IncidencesViewModelOutputs {
  final IncidencesUseCase _incidencesUseCase;
  final AppPreferences _appPreferences;

  IncidencesViewModel(this._incidencesUseCase, this._appPreferences);

  final _incidencesStrCtrl = BehaviorSubject<List<Incidence>>();
  final _areasStrCtrl = BehaviorSubject<List<Area>>();
  final _prioritysStrCtrl = BehaviorSubject<List<Name>>();
  final _activesStrCtrl = BehaviorSubject<List<bool>?>();
  final _isLoading = BehaviorSubject<bool>();
  final _incidenceSelStrCtrl = BehaviorSubject<IncidenceSel>();
  final _incidenceSelIncidenceStrCtrl = BehaviorSubject<IncidenceSel>();
  final List<Incidence> _incidences = [];

  @override
  void start() {
    inputIncidenceSel.add(IncidenceSel());
    areas();
    super.start();
  }

  @override
  void dispose() async {
    await _incidencesStrCtrl.drain();
    _incidencesStrCtrl.close();
    await _areasStrCtrl.drain();
    _areasStrCtrl.close();
    await _prioritysStrCtrl.drain();
    _prioritysStrCtrl.close();
    await _activesStrCtrl.drain();
    _activesStrCtrl.close();
    await _isLoading.drain();
    _isLoading.close();
    await _incidenceSelStrCtrl.drain();
    _incidenceSelStrCtrl.close(); await _incidenceSelIncidenceStrCtrl.drain();
    _incidenceSelIncidenceStrCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputIncidences => _incidencesStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Sink get inputAreas => _areasStrCtrl.sink;

  @override
  Sink get inputPrioritys => _prioritysStrCtrl.sink;

  @override
  Sink get inputActives => _activesStrCtrl.sink;

  @override
  Sink get inputIncidenceSel => _incidenceSelStrCtrl.sink;

  @override
  Sink get inputIncidenceSelIncidence => _incidenceSelIncidenceStrCtrl.sink;

  @override
  Stream<List<Incidence>> get outputIncidences =>
      _incidencesStrCtrl.stream.map((incidences) => incidences);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  Stream<List<Area>> get outputAreas =>
      _areasStrCtrl.stream.map((areas) => areas);

  @override
  Stream<List<Name>> get outputPrioritys =>
      _prioritysStrCtrl.stream.map((prioritys) => prioritys);

  @override
  Stream<List<bool>?> get outputActives =>
      _activesStrCtrl.stream.map((boleans) => boleans);

  @override
  Stream<IncidenceSel> get outputIncidenceSel =>
      _incidenceSelStrCtrl.stream.map((incidenceSel) => incidenceSel);
  @override
  Stream<IncidenceSel> get outputIncidenceSelIncidence =>
      _incidenceSelIncidenceStrCtrl.stream.map((incidenceSel) => incidenceSel);

  @override
  incidences() async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase
              .execute(IncidencesUseCaseInput(limit: 25, offset: 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              limit: 25, offset: _incidences.length - 1)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
   prioritys();
  }

  @override
  incidencesArea(String area) async {
    _incidences.clear();
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.incidencesArea(
              IncidencesUseCaseInput(area: area, limit: 25, offset: 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesArea(IncidencesUseCaseInput(
              area: area, limit: 25, offset: _incidences.length - 1)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesAreaPriority(String area, String priority) async {
    _incidences.clear();
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.incidencesAreaPriority(IncidencesUseCaseInput(
              priority: priority, area: area, limit: 25, offset: 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesAreaPriority(IncidencesUseCaseInput(
              priority: priority,
              area: area,
              limit: 25,
              offset: _incidences.length - 1)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  incidencesAreaPriorityActive(
      String area, String priority, bool active) async {
    _incidences.clear();
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase.incidencesAreaPriorityActive(
              IncidencesUseCaseInput(
                  active: active,
                  priority: priority,
                  area: area,
                  limit: 25,
                  offset: 0)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesAreaPriorityActive(
              IncidencesUseCaseInput(
                  active: active,
                  priority: priority,
                  area: area,
                  limit: 25,
                  offset: _incidences.length - 1)))
          .fold((l) {}, (incidences) {
        _incidences.addAll(incidences);
        inputIncidences.add(_incidences);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }

  @override
  areas() async {
    (await _incidencesUseCase.areas(null)).fold((l) {}, (areas) {
      inputAreas.add(areas);
      incidences();
    });
  }

  @override
  prioritys() async {
    (await _incidencesUseCase.prioritys(null)).fold((l) {}, (prioritys) {
      inputPrioritys.add(prioritys);
    });
  }

  @override
  changeIncidenceSel(IncidenceSel incidenceSel) async {
    inputIncidenceSel.add(incidenceSel);
    if (incidenceSel.area != '') {
      await prioritys();
      inputActives.add(null);
      if (incidenceSel.priority == '') {
        await incidencesArea(incidenceSel.area);
      } else {
        _actives();
        if (incidenceSel.active == null) {
          await incidencesAreaPriority(
              incidenceSel.area, incidenceSel.priority);
        } else {
          await incidencesAreaPriorityActive(
              incidenceSel.area, incidenceSel.priority, incidenceSel.active!);
        }
      }
    }
  }
  @override
  changeIncidenceSelIncidence(IncidenceSel incidenceSel) async {
    inputIncidenceSelIncidence.add(incidenceSel);
  }
  _actives() {
    inputActives.add([true, false]);
  }
}

abstract class IncidencesViewModelInputs {
  Sink get inputIncidences;

  Sink get inputIsLoading;

  Sink get inputAreas;

  Sink get inputPrioritys;

  Sink get inputActives;

  Sink get inputIncidenceSel;
  Sink get inputIncidenceSelIncidence;

  incidences();

  incidencesArea(String area);

  incidencesAreaPriority(String area, String priority);

  incidencesAreaPriorityActive(String area, String priority, bool active);

  changeIsLoading(bool isLoading);

  areas();

  prioritys();

  changeIncidenceSel(IncidenceSel incidenceSel);
  changeIncidenceSelIncidence(IncidenceSel incidenceSel);
}

abstract class IncidencesViewModelOutputs {
  Stream<List<Incidence>> get outputIncidences;

  Stream<bool> get outputIsLoading;

  Stream<List<Area>> get outputAreas;

  Stream<List<Name>> get outputPrioritys;

  Stream<List<bool>?> get outputActives;

  Stream<IncidenceSel> get outputIncidenceSel;
  Stream<IncidenceSel> get outputIncidenceSelIncidence;
}
