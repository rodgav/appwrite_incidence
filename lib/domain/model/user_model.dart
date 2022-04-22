class Users {
  Users({
    required this.name,
    required this.areaId,
    required this.active,
    required this.typeUser,
    required this.read,
    required this.write,
    required this.id,
    required this.collection,
  });

  String name;
  String areaId;
  bool active;
  dynamic typeUser;
  List<String> read;
  List<String> write;
  String id;
  String collection;
}
