class AboutModel {
  AboutModel({
    required this.title,
    required this.rows,
  });
  late final String title;
  late final List<Rows> rows;

  AboutModel.fromJson(Map<String, dynamic> json){
    title = json['title'] ?? "";
    rows = List.from(json['rows']).map((e)=>Rows.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["title"] = title;
    _data["rows"] = rows.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Rows {
  Rows({
    required this.title,
    required this.description,
    required this.imageHref,
  });
  late final String title;
  late final String description;
  late final String imageHref;

  Rows.fromJson(Map<String, dynamic> json){
    title = json["title"] ?? "";
    description = json["description"] ?? "No content";
    imageHref = json["image_href"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["title"] = title;
    _data["description"] = description;
    _data["image_href"] = imageHref;
    return _data;
  }
}