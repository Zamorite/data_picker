import 'dart:convert';

class Config {
  Config({
    this.key,
    this.leading,
    this.defaults,
    this.searchFields,
    required this.label,
  });

  final String? key;
  final String label;
  final String? leading;
  final List<String>? defaults;
  final List<String>? searchFields;

  Config copyWith({
    String? key,
    String? label,
    String? leading,
    List<String>? defaults,
    List<String>? searchFields,
  }) =>
      Config(
        key: key ?? this.key,
        label: label ?? this.label,
        leading: leading ?? this.leading,
        defaults: defaults ?? this.defaults,
        searchFields: searchFields ?? this.searchFields,
      );

  factory Config.fromJson(String str) => Config.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Config.fromMap(Map<String, dynamic> json) => Config(
        key: json["key"] == null ? null : json["key"],
        leading: json["leading"] == null ? null : json["leading"],
        label: json["label"] == null ? 'null' : json["label"],
        searchFields: json["search_fields"] == null
            ? null
            : List<String>.from(
                json["search_fields"].map((x) => x),
              ),
        defaults: json["defaults"] == null
            ? null
            : List<String>.from(
                json["defaults"].map((x) => x),
              ),
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "leading": leading == null ? null : leading,
        "label": label, // == null ? null : label,
        "search_fields": searchFields == null
            ? null
            : List<dynamic>.from(
                (searchFields ?? []).map((x) => x),
              ),
        "defaults": defaults == null
            ? null
            : List<dynamic>.from(
                (defaults ?? []).map((x) => x),
              ),
      };
}

//* Schema
// {
//     "key": "",
//     "leading": "",
//     "label": "",
//     "search_fields": [
//         "",
//         ""
//         ],
//     "defaults": [
//         "",
//         ""
//         ]
// }
