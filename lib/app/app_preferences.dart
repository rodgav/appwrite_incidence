import 'package:appwrite_incidence/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'encrypt_helper.dart';

const String languageKey = 'languageKeyAdmin';
const String sessionKey = 'sessionKeyAdmin';
const String userKey = 'userKeyAdmin';
const String nameKey = 'nameKeyAdmin';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  final EncryptHelper _encryptHelper;

  AppPreferences(this._sharedPreferences, this._encryptHelper);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(languageKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.spanish.getValue();
    }
  }

  void setAppLanguage(String currentLanguage) {
    if (currentLanguage == LanguageType.spanish.getValue()) {
      _sharedPreferences.setString(
          languageKey, LanguageType.spanish.getValue());
    } else {
      _sharedPreferences.setString(
          languageKey, LanguageType.english.getValue());
    }
  }

  Locale getLocale() {
    String curentLanguage = getAppLanguage();
    if (curentLanguage == LanguageType.english.getValue()) {
      return englishLocal;
    } else {
      return spanishLocal;
    }
  }

  Future<void> setSessionIds(
      String sessionId, String userId, String name) async {
    await _sharedPreferences.setString(
        userKey, _encryptHelper.encrypt(userId) ?? '');
    await _sharedPreferences.setString(
        sessionKey, _encryptHelper.encrypt(sessionId) ?? '');
    await _sharedPreferences.setString(
        nameKey, _encryptHelper.encrypt(name) ?? '');
  }

  String getUserId() {
    final userIdEncry = _sharedPreferences.getString(userKey) ?? '';
    final userIdDecry = _encryptHelper.decrypt(userIdEncry) ?? '';
    if (userIdDecry != '') {
      return userIdDecry;
    }
    return '';
  }

  String getSessionId() {
    final sessionIdEncry = _sharedPreferences.getString(sessionKey) ?? '';
    final sessionIdDecry = _encryptHelper.decrypt(sessionIdEncry) ?? '';
    if (sessionIdDecry != '') {
      return sessionIdDecry;
    }
    return '';
  }

  String getName() {
    final nameEncry = _sharedPreferences.getString(nameKey) ?? '';
    final nameDecry = _encryptHelper.decrypt(nameEncry) ?? '';
    if (nameDecry != '') {
      return nameDecry;
    }
    return '';
  }

  Future<void> logout() async {
    await _sharedPreferences.remove(languageKey);
    await _sharedPreferences.remove(sessionKey);
    await _sharedPreferences.remove(userKey);
  }
}
