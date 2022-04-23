import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';

const cachePrioritysKey = 'cachePrioritysKey';
const cacheTypeUsersKey = 'cacheTypeUsersKey';
const cacheUserKey = 'cacheUserKey';
const cacheInterval = 180 * 10000;

abstract class LocalDataSource {
  void clearCache();

  void removeFromCache(String key);

  Future<void> savePrioritysToCache(List<Name> names);

  Future<List<Name>> getPrioritys();

  Future<void> saveTypeUsersToCache(List<Name> names);

  Future<List<Name>> getTypeUsers();

  Future<void> saveUser(User user);
  User getUser();
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
      throw 'error cache prioritys';
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
      throw 'error cache type Users';
    }
  }

  @override
  Future<void> saveUser(User user) async{
    cacheMap[cacheUserKey] = CachedItem(user);
  }

  @override
  User getUser() {
    CachedItem? cachedItem = cacheMap[cacheUserKey];
    if(cachedItem!=null){
      return cachedItem.data;
    }else{
      throw 'error cache user';
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
