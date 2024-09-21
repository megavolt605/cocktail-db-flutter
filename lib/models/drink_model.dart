class DrinkModel {
  String? id;
  String? name;
  String? image;
  DrinkModel({required this.id, this.name, this.image});
  DrinkModel.fromJson(Map<String, dynamic> json) {
    id = json["idDrink"];
    name = json["strDrink"];
    image = json["strDrinkThumb"];
  }
}

class DrinkListModel {
  List<DrinkModel> values = [];

  DrinkListModel({required this.values});
  factory DrinkListModel.fromJson(Map<String, dynamic> json) {
    var drinksJson = json['drinks'] as List;
    var drinks =
        drinksJson.map((itemJson) => DrinkModel.fromJson(itemJson)).toList();
    return DrinkListModel(values: drinks);
  }
}
