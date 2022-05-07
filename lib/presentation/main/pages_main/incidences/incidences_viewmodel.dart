import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/usecase/incidences_usecase.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:appwrite_incidence/presentation/common/dialog_render/dialog_render.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class IncidencesViewModel extends BaseViewModel
    with IncidencesViewModelInputs, IncidencesViewModelOutputs {
  final IncidencesUseCase _incidencesUseCase;
  final DialogRender _dialogRender;
  final String username;

  IncidencesViewModel(this._incidencesUseCase, this._dialogRender,
      AppPreferences _appPreferences)
      : username = _appPreferences.getName();

  final _incidencesStrCtrl = PublishSubject<List<Incidence>>();
  final _areasStrCtrl = BehaviorSubject<List<Area>>();
  final _prioritysStrCtrl = BehaviorSubject<List<Name>>();
  final _activesStrCtrl = BehaviorSubject<List<bool>?>();
  final _isLoading = BehaviorSubject<bool>();
  final _incidenceSelStrCtrl = BehaviorSubject<IncidenceSel>();
  final _incidenceSelIncidenceStrCtrl = BehaviorSubject<IncidenceSel>();
  final List<Incidence> _incidences = [];
  int total = 0;

  @override
  void start() {
    inputIncidenceSel.add(IncidenceSel());
    areas();
    super.start();
  }

  @override
  void dispose() async {
    _incidences.clear();
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
    _incidenceSelStrCtrl.close();
    await _incidenceSelIncidenceStrCtrl.drain();
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
  incidences(bool firstQuery) async {
    if (_incidences.isEmpty) {
      _incidences.clear();
      (await _incidencesUseCase
              .execute(IncidencesUseCaseInput(limit: 25, offset: 0)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.execute(IncidencesUseCaseInput(
              limit: 25,
              offset: _incidences.length < total
                  ? _incidences.length - 1
                  : _incidences.length)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
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
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesArea(IncidencesUseCaseInput(
              area: area,
              limit: 25,
              offset: _incidences.length < total
                  ? _incidences.length - 1
                  : _incidences.length)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
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
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesAreaPriority(IncidencesUseCaseInput(
              priority: priority,
              area: area,
              limit: 25,
              offset: _incidences.length < total
                  ? _incidences.length - 1
                  : _incidences.length)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
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
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
        inputIncidences.add(_incidences);
      });
    } else {
      (await _incidencesUseCase.incidencesAreaPriorityActive(
              IncidencesUseCaseInput(
                  active: active,
                  priority: priority,
                  area: area,
                  limit: 25,
                  offset: _incidences.length < total
                      ? _incidences.length - 1
                      : _incidences.length)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidences.addAll(incidences.incidences);
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
      inputAreas.add(areas.areas);
    });
    incidences(true);
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
    _incidences.clear();
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
          await incidencesAreaPriorityActive(incidenceSel.area,
              incidenceSel.priority, incidenceSel.active ?? false);
        }
      }
    }
  }

  @override
  changeIncidenceSelIncidence(IncidenceSel incidenceSel) async {
    inputIncidenceSelIncidence.add(incidenceSel);
  }

  @override
  createIncidence(Incidence incidence, BuildContext context) async {
    final s = S.of(context);
    (await _incidencesUseCase.incidenceCreate(incidence)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      inputIncidenceSel.add(IncidenceSel());
      Navigator.of(context).pop();
      _incidences.clear();
      incidences(true);
    });
  }

  @override
  updateIncidence(Incidence incidence, BuildContext context) async {
    final s = S.of(context);
    (await _incidencesUseCase.incidenceUpdate(incidence)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      inputIncidenceSel.add(IncidenceSel());
      Navigator.of(context).pop();
      _incidences.clear();
      incidences(true);
    });
  }

  @override
  pickImage(Incidence? incidence, IncidenceSel incidenceSel) async {
    final image = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg']);
    if (image != null) {
      final uint8list = image.files.first.bytes!;
      final name = image.files.first.name;
      (await _incidencesUseCase
              .createFile(IncidenceUseCaseFile(uint8list, name)))
          .fold((failure) {}, (file) async {
        if (incidence != null) {
          (await _incidencesUseCase.deleteFile(incidence.image))
              .fold((failure) => null, (r) => null);
          (await _incidencesUseCase.incidenceUpdate(Incidence(
                  name: incidence.name,
                  description: incidence.description,
                  dateCreate: incidence.dateCreate,
                  image: file.$id,
                  priority: incidence.priority,
                  area: incidence.area,
                  employe: incidence.employe,
                  supervisor: incidence.supervisor,
                  solution: incidence.solution,
                  dateSolution: incidence.dateSolution,
                  active: incidence.active,
                  read: [],
                  write: [],
                  id: incidence.id,
                  collection: '')))
              .fold((failure) => null, (stores) => null);
        }
        inputIncidenceSelIncidence.add(IncidenceSel(
            area: incidenceSel.area,
            priority: incidenceSel.priority,
            active: incidenceSel.active,
            image: file.$id));
      });
    }
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

  incidences(bool firstQuery);

  incidencesArea(String area);

  incidencesAreaPriority(String area, String priority);

  incidencesAreaPriorityActive(String area, String priority, bool active);

  changeIsLoading(bool isLoading);

  areas();

  prioritys();

  changeIncidenceSel(IncidenceSel incidenceSel);

  changeIncidenceSelIncidence(IncidenceSel incidenceSel);

  createIncidence(Incidence incidence, BuildContext context);

  updateIncidence(Incidence incidence, BuildContext context);

  pickImage(Incidence? incidence, IncidenceSel incidenceSel);
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
