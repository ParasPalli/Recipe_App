import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipes_model.dart';

Future<List<RecipesModel>?> fetchReceipes(String category) async {
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['meals'];
    List<RecipesModel> recipes =
        jsonData.map((element) => RecipesModel.fromJson(element)).toList();

    return recipes;
  } else {
    print('Recipes Service Error');
  }
  return null;
}
