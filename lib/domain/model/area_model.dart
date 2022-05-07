class Area {
  Area({
    required this.name,
    required this.description,
    required this.read,
    required this.write,
    required this.id,
    required this.collection,
  });

  String name;
  String description;
  List<String> read;
  List<String> write;
  String id;
  String collection;
}

class Areas {
  List<Area> areas;
  int total;

  Areas({required this.areas, required this.total});
}
