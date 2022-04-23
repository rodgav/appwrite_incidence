import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/usecase/areas_usecase.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class AreasViewModel extends BaseViewModel
    with AreasViewModelInputs, AreasViewModelOutputs {
  final AreasUseCase _areasUseCase;
  final AppPreferences _appPreferences;

  AreasViewModel(this._areasUseCase, this._appPreferences);

  final _areasStrCtrl = BehaviorSubject<List<Area>>();
  final _isLoading = BehaviorSubject<bool>();
  final List<Area> _areas = [];

  @override
  void start() {
    areas();
    super.start();
  }

  @override
  void dispose() async {
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
        _areas.addAll(areas);
        inputAreas.add(_areas);
      });
    } else {
      (await _areasUseCase.execute(AreasUseCaseInput(
              25, _areas.length > 1 ? _areas.length - 1 : _areas.length)))
          .fold((l) {}, (areas) {
        _areas.addAll(areas);
        inputAreas.add(_areas);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }
}

abstract class AreasViewModelInputs {
  Sink get inputAreas;

  Sink get inputIsLoading;

  areas();

  changeIsLoading(bool isLoading);
}

abstract class AreasViewModelOutputs {
  Stream<List<Area>> get outputAreas;

  Stream<bool> get outputIsLoading;
}
