import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/data/data_source/local_data_source.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/usecase/main_usecase.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/resources/routes_manager.dart';
import 'package:appwrite_incidence/presentation/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final MainUseCase _mainUseCase;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  MainViewModel(this._mainUseCase, this._appPreferences, this._localDataSource);

  final _incidencesSearchStrCtrl = BehaviorSubject<List<Incidence>>();
  final _areasSearchStrCtrl = BehaviorSubject<List<Area>>();
  final _usersSearchStrCtrl = BehaviorSubject<List<UsersModel>>();
  final _isLoading = BehaviorSubject<bool>();
  final _userStrCtrl = BehaviorSubject<UsersModel>();
  final List<Incidence> _incidencesSearch = [];
  final List<Area> _areasSearch = [];
  final List<UsersModel> _usersSearch = [];
  String _query = '';
  int total = 0;

  @override
  void start() {
    account();
    super.start();
  }

  @override
  void dispose() async {
    _incidencesSearch.clear();
    _areasSearch.clear();
    _usersSearch.clear();
    await _incidencesSearchStrCtrl.drain();
    _incidencesSearchStrCtrl.close();
    await _areasSearchStrCtrl.drain();
    _areasSearchStrCtrl.close();
    await _usersSearchStrCtrl.drain();
    _usersSearchStrCtrl.close();
    await _isLoading.drain();
    _isLoading.close();
    await _userStrCtrl.drain();
    _userStrCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputIncidencesSearch => _incidencesSearchStrCtrl.sink;

  @override
  Sink get inputAreasSearch => _areasSearchStrCtrl.sink;

  @override
  Sink get inputUsersSearch => _usersSearchStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Sink get inputUser => _userStrCtrl.sink;

  @override
  Stream<List<Incidence>> get outputIncidencesSearch =>
      _incidencesSearchStrCtrl.stream.map((incidences) => incidences);

  @override
  Stream<List<Area>> get outputAreasSearch =>
      _areasSearchStrCtrl.stream.map((areas) => areas);

  @override
  Stream<List<UsersModel>> get outputUsersSearch =>
      _usersSearchStrCtrl.stream.map((users) => users);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  Stream<UsersModel> get outputUser => _userStrCtrl.stream.map((user) => user);

  @override
  incidencesSearch(String search) async {
    print('search $search');
    if (_query != search) {
      _query = search;
      _incidencesSearch.clear();
      (await _mainUseCase.execute(MainUseCaseInput(search, 25, 0))).fold((l) {
        _query = '';
      }, (incidences) {
        total = incidences.total;
        _incidencesSearch.addAll(incidences.incidences);
        inputIncidencesSearch.add(_incidencesSearch);
      });
    } else {
      (await _mainUseCase.execute(MainUseCaseInput(
              search,
              25,
              _incidencesSearch.length < total
                  ? _incidencesSearch.length - 1
                  : _incidencesSearch.length)))
          .fold((l) {}, (incidences) {
        total = incidences.total;
        _incidencesSearch.addAll(incidences.incidences);
        inputIncidencesSearch.add(_incidencesSearch);
      });
      changeIsLoading(false);
    }
  }

  @override
  areasSearch(String search) async {
    if (_query != search) {
      _query = search;
      _areasSearch.clear();
      (await _mainUseCase.areas(MainUseCaseInput(search, 25, 0))).fold((l) {
        _query = '';
      }, (areas) {
        total = areas.total;
        _areasSearch.addAll(areas.areas);
        inputAreasSearch.add(_areasSearch);
      });
    } else {
      (await _mainUseCase.areas(MainUseCaseInput(
              search,
              25,
              _areasSearch.length < total
                  ? _areasSearch.length - 1
                  : _areasSearch.length)))
          .fold((l) {}, (areas) {
        total = areas.total;
        _areasSearch.addAll(areas.areas);
        inputAreasSearch.add(_areasSearch);
      });
      changeIsLoading(false);
    }
  }

  @override
  usersSearch(String search) async {
    if (_query != search) {
      _query = search;
      _usersSearch.clear();
      (await _mainUseCase.users(MainUseCaseInput(search, 25, 0))).fold((l) {
        _query = '';
      }, (users) {
        total = users.total;
        _usersSearch.addAll(users.usersModels);
        inputUsersSearch.add(_usersSearch);
      });
    } else {
      (await _mainUseCase.users(MainUseCaseInput(
              search,
              25,
              _usersSearch.length < total
                  ? _usersSearch.length - 1
                  : _usersSearch.length)))
          .fold((l) {}, (users) {
        total = users.total;
        _usersSearch.addAll(users.usersModels);
        inputUsersSearch.add(_usersSearch);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }

  @override
  deleteSession(BuildContext context) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.empty));
    final sessionId = _appPreferences.getSessionId();
    (await _mainUseCase.deleteSession(MainDeleteSessionUseCaseInput(sessionId)))
        .fold((f) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, f.message));
    }, (r) async {
      inputState.add(ContentState());
      await _appPreferences.logout();
      _localDataSource.clearCache();
      GoRouter.of(context).go(Routes.splashRoute);
    });
  }

  @override
  account() async {
    (await _mainUseCase.user(_appPreferences.getUserId())).fold((f) => null,
        (user) async {
      inputUser.add(user);
    });
  }
}

abstract class MainViewModelInputs {
  Sink get inputIncidencesSearch;

  Sink get inputAreasSearch;

  Sink get inputUsersSearch;

  Sink get inputIsLoading;

  Sink get inputUser;

  incidencesSearch(String search);

  areasSearch(String search);

  usersSearch(String search);

  changeIsLoading(bool isLoading);

  deleteSession(BuildContext context);

  account();
}

abstract class MainViewModelOutputs {
  Stream<List<Incidence>> get outputIncidencesSearch;

  Stream<List<Area>> get outputAreasSearch;

  Stream<List<UsersModel>> get outputUsersSearch;

  Stream<bool> get outputIsLoading;

  Stream<UsersModel> get outputUser;
}
