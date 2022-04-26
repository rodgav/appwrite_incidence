// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Contraseña`
  String get inputPassword {
    return Intl.message(
      'Contraseña',
      name: 'inputPassword',
      desc: '',
      args: [],
    );
  }

  /// `Correo`
  String get inputEmail {
    return Intl.message(
      'Correo',
      name: 'inputEmail',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get login {
    return Intl.message(
      'Ingresar',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Ruta no encontrada`
  String get noRouteFound {
    return Intl.message(
      'Ruta no encontrada',
      name: 'noRouteFound',
      desc: '',
      args: [],
    );
  }

  /// `Éxito`
  String get success {
    return Intl.message(
      'Éxito',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Correo enviado`
  String get sendEmail {
    return Intl.message(
      'Correo enviado',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get close {
    return Intl.message(
      'Cerrar',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get accept {
    return Intl.message(
      'Aceptar',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Cargando...`
  String get loading {
    return Intl.message(
      'Cargando...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Reintentar`
  String get retryAgain {
    return Intl.message(
      'Reintentar',
      name: 'retryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Área`
  String get area {
    return Intl.message(
      'Área',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Prioridad`
  String get priority {
    return Intl.message(
      'Prioridad',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Activo`
  String get active {
    return Intl.message(
      'Activo',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get search {
    return Intl.message(
      'Buscar',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Incidencias`
  String get incidences {
    return Intl.message(
      'Incidencias',
      name: 'incidences',
      desc: '',
      args: [],
    );
  }

  /// `Areas`
  String get areas {
    return Intl.message(
      'Areas',
      name: 'areas',
      desc: '',
      args: [],
    );
  }

  /// `Supervisores`
  String get supervisors {
    return Intl.message(
      'Supervisores',
      name: 'supervisors',
      desc: '',
      args: [],
    );
  }

  /// `Empleados`
  String get employees {
    return Intl.message(
      'Empleados',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `Supervisor`
  String get supervisor {
    return Intl.message(
      'Supervisor',
      name: 'supervisor',
      desc: '',
      args: [],
    );
  }

  /// `Empleado`
  String get employe {
    return Intl.message(
      'Empleado',
      name: 'employe',
      desc: '',
      args: [],
    );
  }

  /// `No hay datos`
  String get noData {
    return Intl.message(
      'No hay datos',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Añadir Área`
  String get addArea {
    return Intl.message(
      'Añadir Área',
      name: 'addArea',
      desc: '',
      args: [],
    );
  }

  /// `Añadir Incidente`
  String get addIncidence {
    return Intl.message(
      'Añadir Incidente',
      name: 'addIncidence',
      desc: '',
      args: [],
    );
  }

  /// `Añadir`
  String get add {
    return Intl.message(
      'Añadir',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de incidencia`
  String get nameIncidence {
    return Intl.message(
      'Nombre de incidencia',
      name: 'nameIncidence',
      desc: '',
      args: [],
    );
  }

  /// `Descripción de inicidencia`
  String get descriptionIncidence {
    return Intl.message(
      'Descripción de inicidencia',
      name: 'descriptionIncidence',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de creación`
  String get dateCreate {
    return Intl.message(
      'Fecha de creación',
      name: 'dateCreate',
      desc: '',
      args: [],
    );
  }

  /// `Solución`
  String get solution {
    return Intl.message(
      'Solución',
      name: 'solution',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de solución`
  String get dateSolution {
    return Intl.message(
      'Fecha de solución',
      name: 'dateSolution',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get save {
    return Intl.message(
      'Guardar',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Nombre error`
  String get nameError {
    return Intl.message(
      'Nombre error',
      name: 'nameError',
      desc: '',
      args: [],
    );
  }

  /// `Descripción error`
  String get descrError {
    return Intl.message(
      'Descripción error',
      name: 'descrError',
      desc: '',
      args: [],
    );
  }

  /// `Empleado error`
  String get employeError {
    return Intl.message(
      'Empleado error',
      name: 'employeError',
      desc: '',
      args: [],
    );
  }

  /// `Supervisor error`
  String get supervisorError {
    return Intl.message(
      'Supervisor error',
      name: 'supervisorError',
      desc: '',
      args: [],
    );
  }

  /// `Solución error`
  String get solutionError {
    return Intl.message(
      'Solución error',
      name: 'solutionError',
      desc: '',
      args: [],
    );
  }

  /// `Área error`
  String get areaError {
    return Intl.message(
      'Área error',
      name: 'areaError',
      desc: '',
      args: [],
    );
  }

  /// `Prioridad error`
  String get priorityError {
    return Intl.message(
      'Prioridad error',
      name: 'priorityError',
      desc: '',
      args: [],
    );
  }

  /// `Editar`
  String get edit {
    return Intl.message(
      'Editar',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Incidencia`
  String get incidence {
    return Intl.message(
      'Incidencia',
      name: 'incidence',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `No tiene los permisos necesarios para esta acción`
  String get notPermission {
    return Intl.message(
      'No tiene los permisos necesarios para esta acción',
      name: 'notPermission',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get confirm {
    return Intl.message(
      'Confirmar',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Usuario`
  String get user {
    return Intl.message(
      'Usuario',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de usuario`
  String get nameUser {
    return Intl.message(
      'Nombre de usuario',
      name: 'nameUser',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get email {
    return Intl.message(
      'Correo electrónico',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico error`
  String get emailError {
    return Intl.message(
      'Correo electrónico error',
      name: 'emailError',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message(
      'Contraseña',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña error`
  String get passwordError {
    return Intl.message(
      'Contraseña error',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de usuario`
  String get typeUser {
    return Intl.message(
      'Tipo de usuario',
      name: 'typeUser',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar el lenguaje`
  String get changeLanguage {
    return Intl.message(
      'Cambiar el lenguaje',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Nombre área`
  String get nameArea {
    return Intl.message(
      'Nombre área',
      name: 'nameArea',
      desc: '',
      args: [],
    );
  }

  /// `Descrición área`
  String get descriptionArea {
    return Intl.message(
      'Descrición área',
      name: 'descriptionArea',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
