class IncidenceSel {
  String area, priority;
  bool? active;

  IncidenceSel({String? area, String? priority, this.active})
      : area = area ?? '',
        priority = priority ?? '';
}
