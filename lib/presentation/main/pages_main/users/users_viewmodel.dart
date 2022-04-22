import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/usecase/users_usecase.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class UsersViewModel extends BaseViewModel
    with UsersViewModelInputs, UsersViewModelOutputs {
  final UsersUseCase _usersUseCase;
  final AppPreferences _appPreferences;

  UsersViewModel(this._usersUseCase, this._appPreferences);

  final _usersStrCtrl = BehaviorSubject<List<Users>>();
  final _isLoading = BehaviorSubject<bool>();
  final List<Users> _users = [];

  @override
  Sink get inputUsers => _usersStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Stream<List<Users>> get outputUsers =>
      _usersStrCtrl.stream.map((users) => users);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  users(String typeUser) async {
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.execute(
              UsersUseCaseInput(typeUser: typeUser, limit: 25, offset: 0)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.execute(UsersUseCaseInput(
              typeUser: typeUser, limit: 25, offset: _users.length - 1)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
  }

  @override
  usersArea(String typeUser) async {
    _users.clear();
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.usersArea(UsersUseCaseInput(
              typeUser: typeUser, areaId: '', limit: 25, offset: 0)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.usersArea(UsersUseCaseInput(
              typeUser: typeUser,
              areaId: '',
              limit: 25,
              offset: _users.length - 1)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
  }

  @override
  usersAreaActive(String typeUser) async {
    _users.clear();
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.usersAreaActive(UsersUseCaseInput(
              typeUser: typeUser,
              areaId: '',
              active: true,
              limit: 25,
              offset: 0)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.usersAreaActive(UsersUseCaseInput(
              typeUser: typeUser,
              areaId: '',
              active: true,
              limit: 25,
              offset: _users.length - 1)))
          .fold((l) {}, (users) {
        _users.addAll(users);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
  }

  @override
  changeIsLoading(bool isLoading) {
    inputIsLoading.add(isLoading);
  }
}

abstract class UsersViewModelInputs {
  Sink get inputUsers;

  Sink get inputIsLoading;

  users(String typeUser);

  usersArea(String typeUser);

  usersAreaActive(String typeUser);

  changeIsLoading(bool isLoading);
}

abstract class UsersViewModelOutputs {
  Stream<List<Users>> get outputUsers;

  Stream<bool> get outputIsLoading;
}
