class DrinkInfoIngredientModel {
  String? name;
  String? measure;
  DrinkInfoIngredientModel({required this.name, this.measure});
}

class DrinkInfoModel {
  String? id;
  String? name;
  String? category;
  String? type;
  String? glass;
  String? instructions;
  String? imageURL;
  List<DrinkInfoIngredientModel> ingredients = [];
  String? modifiedDate;
  DrinkInfoModel({
    required this.id,
    this.name,
    this.category,
    this.type,
    this.glass,
    this.instructions,
    this.imageURL,
    required this.ingredients,
    this.modifiedDate,
  });
  DrinkInfoModel.fromJson(Map<String, dynamic> json) {
    var drinksJson = (json['drinks'] as List).first;

    id = drinksJson['idDrink'];
    name = drinksJson['strDrink'];
    category = drinksJson['strCategory'];
    type = drinksJson['strAlcoholic'];
    glass = drinksJson['strGlass'];
    instructions = drinksJson['strInstructions'];
    imageURL = drinksJson['strDrinkThumb'];
    var values = List<DrinkInfoIngredientModel>.empty(growable: true);
    for (var index = 1; index <= 15; index++) {
      var ingredientName = drinksJson['strIngredient$index'];
      var ingredientMeasure = drinksJson['strMeasure$index'];
      if (ingredientName != null) {
        values.add(
          DrinkInfoIngredientModel(
              name: ingredientName, measure: ingredientMeasure),
        );
      }
    }
    ingredients = values;
    modifiedDate = drinksJson['dateModified'];
  }
}
