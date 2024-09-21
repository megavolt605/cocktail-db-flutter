import 'package:hello_flutter/api.dart';

class FilterModel {
  String? name;
  FilterModel({required this.name});
  FilterModel.fromJson(Map<String, dynamic> json, String keyName) {
    name = json[keyName];
  }
}

class ListModel {
  List<FilterModel> values = [];

  ListModel({required this.values});
  factory ListModel.fromJson(Map<String, dynamic> json, FilterType filter) {
    var drinksJson = json['drinks'] as List;
    var drinks = drinksJson
        .map((itemJson) => FilterModel.fromJson(itemJson, filter.keyName))
        .toList();
    return ListModel(values: drinks);
  }
}
