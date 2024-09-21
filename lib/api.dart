import 'dart:async';
import 'dart:convert';
import 'package:hello_flutter/models/drink_info_model.dart';
import 'package:hello_flutter/models/drink_model.dart';
import 'package:hello_flutter/models/filter_model.dart';
import 'models/ingredient_model.dart';
import 'package:http/http.dart' as http;

enum FilterType {
  category,
  glass,
  ingredient,
  alcoholic;

  String _parameter() {
    switch (this) {
      case category:
        return 'c';
      case glass:
        return 'g';
      case ingredient:
        return 'i';
      case alcoholic:
        return 'a';
    }
  }

  String get parameter => _parameter();

  String _name() {
    switch (this) {
      case category:
        return 'Categories';
      case glass:
        return 'Glasses';
      case ingredient:
        return 'Ingredients';
      case alcoholic:
        return 'Alcoholic';
    }
  }

  String get name => _name();

  String _keyName() {
    switch (this) {
      case category:
        return 'strCategory';
      case glass:
        return 'strGlass';
      case ingredient:
        return 'strIngredient1';
      case alcoholic:
        return 'strAlcoholic';
    }
  }

  String get keyName => _keyName();
}

enum Api {
  list,
  filter,
  lookup, // lookup drink
  search;

  static var host = 'www.thecocktaildb.com';
  static var path = 'api/json/v1/1/';

  Uri listUrl({required FilterType filter, String? value}) {
    return Uri.https(
        Api.host, '${Api.path}$name.php', {filter.parameter: value ?? 'list'});
  }

  Uri infoUrl({required String id}) {
    return Uri.https(Api.host, '${Api.path}$name.php', {'i': id});
  }

  Map<String, String> get defaultHeaders => {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        "Access-Control-Allow-Headers": "X-Requested-With",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
      };

  Future<List<FilterModel>> requestList(
      {required FilterType filterType, String? value}) async {
    var url = Api.list.listUrl(filter: filterType, value: value);
    print(url);
    final response = await http.get(url, headers: defaultHeaders);
    ListModel list = ListModel.fromJson(json.decode(response.body), filterType);
    return list.values;
  }

  Future<List<DrinkModel>> requestDrinkList(
      {required FilterType filterType, String? value}) async {
    var url = Api.filter.listUrl(filter: filterType, value: value);
    print(url);
    final response = await http.get(url, headers: defaultHeaders);
    DrinkListModel list = DrinkListModel.fromJson(json.decode(response.body));
    return list.values;
  }

  Future<DrinkInfoModel> requestDrinkInfo({required String drinkId}) async {
    var url = Api.lookup.infoUrl(id: drinkId);
    print(url);
    final response = await http.get(url, headers: defaultHeaders);
    DrinkInfoModel model = DrinkInfoModel.fromJson(json.decode(response.body));
    return model;
  }

  Future<IngredientModel> requestIngridientInfo(
      {required String ingridientId}) async {
    var url = Api.search.infoUrl(id: ingridientId);
    print(url);
    final response = await http.get(url, headers: defaultHeaders);
    IngredientModel model =
        IngredientModel.fromJson(json.decode(response.body));
    return model;
  }
}
