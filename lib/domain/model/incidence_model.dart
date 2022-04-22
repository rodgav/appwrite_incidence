class Incidence {
  Incidence({
    required this.name,
    required this.description,
    required this.dateReport,
    required this.image,
    required this.typeReport,
    required this.areaId,
    required this.employeId,
    required this.supervisorId,
    required this.solution,
    required this.dateSolution,
    required this.active,
    required this.read,
    required this.write,
    required this.id,
    required this.collection,
  });

  String name;
  String description;
  DateTime dateReport;
  String image;
  String typeReport;
  String areaId;
  String employeId;
  String supervisorId;
  String solution;
  DateTime? dateSolution;
  bool active;
  List<String> read;
  List<String> write;
  String id;
  String collection;
}