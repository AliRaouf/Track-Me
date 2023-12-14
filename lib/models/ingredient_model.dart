class IngredientModel {
  String? name;
  double? calories;
  double? servingSizeG;
  double? fatTotalG;
  double? fatSaturatedG;
  double? proteinG;
  int? sodiumMg;
  int? potassiumMg;
  int? cholesterolMg;
  double? carbohydratesTotalG;
  double? fiberG;
  double? sugarG;

  IngredientModel({
    this.name,
    this.calories,
    this.servingSizeG,
    this.fatTotalG,
    this.fatSaturatedG,
    this.proteinG,
    this.sodiumMg,
    this.potassiumMg,
    this.cholesterolMg,
    this.carbohydratesTotalG,
    this.fiberG,
    this.sugarG,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      calories: json['calories'],
      servingSizeG: json['serving_size_g'],
      fatTotalG: json['fat_total_g'],
      fatSaturatedG: json['fat_saturated_g'],
      proteinG: json['protein_g'],
      sodiumMg: json['sodium_mg'].toInt(),
      potassiumMg: json['potassium_mg'].toInt(),
      cholesterolMg: json['cholesterol_mg'].toInt(),
      carbohydratesTotalG: json['carbohydrates_total_g'],
      fiberG: json['fiber_g'],
      sugarG: json['sugar_g'],
    );
  }

  factory IngredientModel.fromList(List<dynamic> jsonList) {
    // Handle the case where the API returns a list of ingredients
    if (jsonList.isNotEmpty) {
      return IngredientModel.fromJson(jsonList.first);
    } else {
      // Return a default instance or handle it according to your needs
      return IngredientModel();
    }
  }

  List<IngredientModel> parseIngredientsList(List<dynamic> jsonList) {
    List<IngredientModel> ingredients = [];
    for (var item in jsonList) {
      ingredients.add(IngredientModel.fromJson(item));
    }
    return ingredients;
  }
}

