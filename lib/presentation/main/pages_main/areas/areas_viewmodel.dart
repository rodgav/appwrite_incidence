import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/usecase/areas_usecase.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:appwrite_incidence/presentation/common/dialog_render/dialog_render.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class AreasViewModel extends BaseViewModel
    with AreasViewModelInputs, AreasViewModelOutputs {
  final AreasUseCase _areasUseCase;
  final DialogRender _dialogRender;

  AreasViewModel(this._areasUseCase, this._dialogRender);

  final _areasStrCtrl = BehaviorSubject<List<Area>>();
  final _isLoading = BehaviorSubject<bool>();
  final List<Area> _areas = [];
  int total = 0;

  @override
  void start() {
    areas();
    super.start();
  }

  @override
  void dispose() async {
    _areas.clear();
    await _areasStrCtrl.drain();
    _areasStrCtrl.close();
    await _isLoading.drain();
    _isLoading.close();
    super.dispose();
  }

  @override
  Sink get inputAreas => _areasStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Stream<List<Area>> get outputAreas =>
      _areasStrCtrl.stream.map((areas) => areas);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  areas() async {
    if (_areas.isEmpty) {
      _areas.clear();
      (await _areasUseCase.execute(AreasUseCaseInput(25, 0))).fold((l) {},
          (areas) {
        total = areas.total;
        _areas.addAll(areas.areas);
        inputAreas.add(_areas);
      });
    } else {
      (await _areasUseCase.execute(AreasUseCaseInput(
              25, _areas.length < total ? _areas.length - 1 : _areas.length)))
          .fold((l) {}, (areas) {
        total = areas.total;
        _areas.addAll(areas.areas);
        inputAreas.add(_areas);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }

  @override
  updateArea(Area area, BuildContext context) async {
    final s = S.of(context);
    (await _areasUseCase.areaUpdate(area)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      Navigator.of(context).pop();
      _areas.clear();
      areas();
    });
  }

  @override
  createArea(Area area, BuildContext context) async {
    final s = S.of(context);
    (await _areasUseCase.areaCreate(area)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      Navigator.of(context).pop();
      _areas.clear();
      areas();
    });
  }
}

abstract class AreasViewModelInputs {
  Sink get inputAreas;

  Sink get inputIsLoading;

  areas();

  changeIsLoading(bool isLoading);

  updateArea(Area area, BuildContext context);

  createArea(Area area, BuildContext context);
}

abstract class AreasViewModelOutputs {
  Stream<List<Area>> get outputAreas;

  Stream<bool> get outputIsLoading;
}
