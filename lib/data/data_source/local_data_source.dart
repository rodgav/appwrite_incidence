import 'package:appwrite_incidence/domain/model/name_model.dart';

const cachePrioritysKey = 'cachePrioritysKey';
const cacheTypeUsersKey = 'cacheTypeUsersKey';
const cacheInterval = 180 * 10000;

abstract class LocalDataSource {
  void clearCache();

  void removeFromCache(String key);

  Future<void> savePrioritysToCache(List<Name> names);

  Future<List<Name>> getPrioritys();

  Future<void> saveTypeUsersToCache(List<Name> names);

  Future<List<Name>> getTypeUsers();
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<void> savePrioritysToCache(List<Name> names) async {
    cacheMap[cachePrioritysKey] = CachedItem(names);
  }

  @override
  Future<List<Name>> getPrioritys() {
    CachedItem? cachedItem = cacheMap[cachePrioritysKey];
    if (cachedItem != null && cachedItem.isValid(cacheInterval)) {
      return cachedItem.data;
    } else {
      throw 'error cache';
    }
  }

  @override
  Future<void> saveTypeUsersToCache(List<Name> names) async {
    cacheMap[cacheTypeUsersKey] = CachedItem(names);
  }

  @override
  Future<List<Name>> getTypeUsers() {
    CachedItem? cachedItem = cacheMap[cacheTypeUsersKey];
    if (cachedItem != null && cachedItem.isValid(cacheInterval)) {
      return cachedItem.data;
    } else {
      throw 'error cache';
    }
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}
