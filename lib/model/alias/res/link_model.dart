import 'package:minify_link/model/alias/res/links.dart';

class LinkModel {
  String? alias;
  Links? links;

  LinkModel({
    this.alias,
    this.links,
  });

  LinkModel.fromJson(dynamic json) {
    alias = json['alias'] as String?;
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alias'] = alias;
    if (links != null) {
      map['_links'] = links?.toJson();
    }
    return map;
  }
}
