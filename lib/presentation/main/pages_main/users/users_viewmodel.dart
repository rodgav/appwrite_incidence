import 'package:appwrite_incidence/data/request/request.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/model/user_sel.dart';
import 'package:appwrite_incidence/domain/usecase/users_usecase.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/base/base_viewmodel.dart';
import 'package:appwrite_incidence/presentation/common/dialog_render/dialog_render.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UsersViewModel extends BaseViewModel
    with UsersViewModelInputs, UsersViewModelOutputs {
  final UsersUseCase _usersUseCase;
  final DialogRender _dialogRender;

  UsersViewModel(this._usersUseCase, this._dialogRender);

  final _usersStrCtrl = BehaviorSubject<List<UsersModel>>();
  final _areasStrCtrl = BehaviorSubject<List<Area>>();
  final _activesStrCtrl = BehaviorSubject<List<bool>?>();
  final _isLoading = BehaviorSubject<bool>();
  final _userSelStrCtrl = BehaviorSubject<UserSel>();
  final _userSelUserStrCtrl = BehaviorSubject<UserSel>();
  final _typeUsersStrCtrl = BehaviorSubject<List<Name>>();
  final List<UsersModel> _users = [];
  int total = 0;

  @override
  void start() {
    inputUserSel.add(UserSel());
    typeUsers();
  }

  @override
  void dispose() async {
    _users.clear();
    await _usersStrCtrl.drain();
    _usersStrCtrl.close();
    await _areasStrCtrl.drain();
    _areasStrCtrl.close();
    await _activesStrCtrl.drain();
    _activesStrCtrl.close();
    await _isLoading.drain();
    _isLoading.close();
    await _userSelStrCtrl.drain();
    _userSelStrCtrl.close();
    await _userSelUserStrCtrl.drain();
    _userSelUserStrCtrl.close();
    await _typeUsersStrCtrl.drain();
    _typeUsersStrCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputUsers => _usersStrCtrl.sink;

  @override
  Sink get inputAreas => _areasStrCtrl.sink;

  @override
  Sink get inputActives => _activesStrCtrl.sink;

  @override
  Sink get inputIsLoading => _isLoading.sink;

  @override
  Sink get inputUserSel => _userSelStrCtrl.sink;

  @override
  Sink get inputUserSelUser => _userSelUserStrCtrl.sink;

  @override
  Sink get inputTypeUsers => _typeUsersStrCtrl.sink;

  @override
  Stream<List<UsersModel>> get outputUsers =>
      _usersStrCtrl.stream.map((users) => users);

  @override
  Stream<List<Area>> get outputAreas =>
      _areasStrCtrl.stream.map((areas) => areas);

  @override
  Stream<List<bool>?> get outputActives =>
      _activesStrCtrl.stream.map((boleans) => boleans);

  @override
  Stream<bool> get outputIsLoading =>
      _isLoading.stream.map((isLoading) => isLoading);

  @override
  Stream<UserSel> get outputUserSel =>
      _userSelStrCtrl.stream.map((userSel) => userSel);

  @override
  Stream<UserSel> get outputUserSelUser =>
      _userSelUserStrCtrl.stream.map((userSel) => userSel);

  @override
  Stream<List<Name>> get outputTypeUsers =>
      _typeUsersStrCtrl.stream.map((typeUsers) => typeUsers);

  @override
  users(bool firstQuery) async {
    firstQuery ? _users.clear() : null;
    if (_users.isEmpty) {
      (await _usersUseCase.execute(UsersUseCaseInput(limit: 25, offset: 0)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.execute(UsersUseCaseInput(
              limit: 25,
              offset:
                  _users.length < total ? _users.length - 1 : _users.length)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
    areas();
  }

  @override
  usersTypeUser(String typeUser) async {
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.usersTypeUser(
              UsersUseCaseInput(typeUser: typeUser, limit: 25, offset: 0)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.usersTypeUser(UsersUseCaseInput(
              typeUser: typeUser,
              limit: 25,
              offset:
                  _users.length < total ? _users.length - 1 : _users.length)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
  }

  @override
  usersTypeUserArea(String typeUser, String area) async {
    _users.clear();
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.usersTypeUserArea(UsersUseCaseInput(
              typeUser: typeUser, area: area, limit: 25, offset: 0)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.usersTypeUserArea(UsersUseCaseInput(
              typeUser: typeUser,
              area: area,
              limit: 25,
              offset:
                  _users.length < total ? _users.length - 1 : _users.length)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
      changeIsLoading(false);
    }
  }

  @override
  usersTypeUserAreaActive(String typeUser, String area, bool active) async {
    _users.clear();
    if (_users.isEmpty) {
      _users.clear();
      (await _usersUseCase.usersTypeUserAreaActive(UsersUseCaseInput(
              typeUser: typeUser,
              area: area,
              active: active,
              limit: 25,
              offset: 0)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
      });
    } else {
      (await _usersUseCase.usersTypeUserAreaActive(UsersUseCaseInput(
              typeUser: typeUser,
              area: area,
              active: active,
              limit: 25,
              offset:
                  _users.length < total ? _users.length - 1 : _users.length)))
          .fold((l) {}, (users) {
        total = users.total;
        _users.addAll(users.usersModels);
        inputUsers.add(_users);
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
    (await _usersUseCase.areas(null)).fold((l) {}, (areas) {
      inputAreas.add(areas);
    });
  }

  @override
  changeUserSel(UserSel userSel) async {
    inputUserSel.add(userSel);
    _users.clear();
    if (userSel.typeUser != '') {
      await areas();
      inputActives.add(null);
      if (userSel.area == '') {
        await usersTypeUser(userSel.typeUser);
      } else {
        _actives();
        if (userSel.active == null) {
          await usersTypeUserArea(userSel.typeUser, userSel.area);
        } else {
          await usersTypeUserAreaActive(
              userSel.typeUser, userSel.area, userSel.active ?? false);
        }
      }
    }
  }

  @override
  changeUserSelUser(UserSel userSel) async {
    inputUserSelUser.add(userSel);
  }

  @override
  typeUsers() async {
    (await _usersUseCase.typeUsers(null)).fold((l) {}, (typeUsers) {
      inputTypeUsers.add(typeUsers);
    });
    users(true);
  }

  @override
  createUser(LoginRequest loginRequest, bool active, String typeUser,
      String area, BuildContext context) async {
    final s = S.of(context);
    (await _usersUseCase.userCreate(
            UsersCreateUseCaseInput(loginRequest, active, typeUser, area)))
        .fold(
            (l) => _dialogRender.showPopUp(
                context,
                DialogRendererType.errorDialog,
                (s.error).toUpperCase(),
                l.message,
                null,
                null,
                null), (r) {
      inputUserSel.add(UserSel());
      Navigator.of(context).pop();
      _users.clear();
      users(true);
    });
  }

  @override
  updateUser(UsersModel users1, BuildContext context) async {
    final s = S.of(context);
    (await _usersUseCase.userUpdate(users1)).fold(
        (l) => _dialogRender.showPopUp(context, DialogRendererType.errorDialog,
            (s.error).toUpperCase(), l.message, null, null, null), (r) {
      inputUserSel.add(UserSel());
      Navigator.of(context).pop();
      _users.clear();
      users(true);
    });
  }

  _actives() {
    inputActives.add([true, false]);
  }
}

abstract class UsersViewModelInputs {
  Sink get inputUsers;

  Sink get inputAreas;

  Sink get inputActives;

  Sink get inputIsLoading;

  Sink get inputUserSel;

  Sink get inputUserSelUser;

  Sink get inputTypeUsers;

  users(bool firstQuery);

  usersTypeUser(String typeUser);

  usersTypeUserArea(String typeUser, String area);

  usersTypeUserAreaActive(String typeUser, String area, bool active);

  changeIsLoading(bool isLoading);

  areas();

  changeUserSel(UserSel userSel);

  changeUserSelUser(UserSel userSel);

  typeUsers();

  createUser(LoginRequest loginRequest, bool active, String typeUser,
      String area, BuildContext context);

  updateUser(UsersModel users1, BuildContext context);
}

abstract class UsersViewModelOutputs {
  Stream<List<UsersModel>> get outputUsers;

  Stream<List<Area>> get outputAreas;

  Stream<List<bool>?> get outputActives;

  Stream<bool> get outputIsLoading;

  Stream<UserSel> get outputUserSel;

  Stream<UserSel> get outputUserSelUser;

  Stream<List<Name>> get outputTypeUsers;
}
