class RecipesModel {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  const RecipesModel({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) {
    return RecipesModel(
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      idMeal: json['idMeal'] as String,
    );
  }
}
