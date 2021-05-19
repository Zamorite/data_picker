import 'dart:convert';

class ListItem {
  ListItem({
    this.key,
    this.leading,
    this.label,
    this.searchFields,
    this.value,
    this.selected,
  });

  final String? key;
  final String? leading;
  final String? label;
  final List<String>? searchFields;
  final dynamic value;
  final bool? selected;

  ListItem copyWith({
    String? key,
    String? leading,
    String? label,
    List<String>? searchFields,
    dynamic value,
    bool? selected,
  }) =>
      ListItem(
        key: key ?? this.key,
        leading: leading ?? this.leading,
        label: label ?? this.label,
        searchFields: searchFields ?? this.searchFields,
        value: value ?? this.value,
        selected: selected ?? this.selected,
      );

  factory ListItem.fromJson(String str) => ListItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListItem.fromMap(Map<String, dynamic> json) => ListItem(
        key: json["key"] == null ? null : json["key"],
        leading: json["leading"] == null ? null : json["leading"],
        label: json["label"] == null ? null : json["label"],
        searchFields: json["search_fields"] == null
            ? null
            : List<String>.from(
                json["search_fields"].map((x) => x),
              ),
        value: json["value"],
        selected: json["selected"] == null ? null : json["selected"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "leading": leading == null ? null : leading,
        "label": label == null ? null : label,
        "search_fields": searchFields == null
            ? null
            : List<dynamic>.from(
                (searchFields ?? []).map((x) => x),
              ),
        "value": value,
        "selected": selected == null ? null : selected,
      };

  @override
  String toString() => label ?? 'null';
}

class ValueClass {
  ValueClass();

  // ValueClass copyWith({
  // }) =>
  //     ValueClass(
  //     );

  factory ValueClass.fromJson(String str) =>
      ValueClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ValueClass.fromMap(Map<String, dynamic> json) => ValueClass();

  Map<String, dynamic> toMap() => {};
}

//* Schema
// [
//     {
//     "leading": "",
//     "label": "",
//     "search_fields": [
//         "",
//         ""
//         ],
//     "value": {},
//     "selected": false
// },
//     {
//     "leading": "",
//     "label": "",
//     "value": "",
//     "selected": false
// },
//     {
//     "leading": "",
//     "label": "",
//     "value": false,
//     "selected": false
// }
// ]
