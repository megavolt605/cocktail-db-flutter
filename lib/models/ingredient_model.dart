class IngredientModel {
  String? id;
  String? name;
  String? description;
  String? type;
  String? alcohol;

  IngredientModel({
    required this.id,
    this.name,
    this.description,
    this.type,
    this.alcohol,
  });

  IngredientModel.fromJson(Map<String, dynamic> json) {
    var ingredientsJson = (json['ingredients'] as List).first;

    id = ingredientsJson['idIngredient'];
    name = ingredientsJson['strIngredient'];
    description = ingredientsJson['strDescription'];
    type = ingredientsJson['strType'];
    alcohol = ingredientsJson['strAlcohol'];
  }
}
