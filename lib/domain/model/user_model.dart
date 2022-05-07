class UsersModel {
  UsersModel({
    required this.name,
    required this.area,
    required this.active,
    required this.typeUser,
    required this.read,
    required this.write,
    required this.id,
    required this.collection,
  });

  String name;
  String area;
  bool active;
  String typeUser;
  List<String> read;
  List<String> write;
  String id;
  String collection;
}

class UsersModels {
  List<UsersModel> usersModels;
  int total;

  UsersModels({required this.usersModels, required this.total});
}
