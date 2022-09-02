class Links {
  String? self;
  String? short;

  Links({
    this.self,
    this.short,
  });

  Links.fromJson(dynamic json) {
    self = json['self'] as String?;
    short = json['short'] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['short'] = short;
    return map;
  }
}
