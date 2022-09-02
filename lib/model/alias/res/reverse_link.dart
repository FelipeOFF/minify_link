class ReverseLink {
  ReverseLink({
    this.url,
  });

  ReverseLink.fromJson(dynamic json) {
    url = json['url'] as String?;
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}
