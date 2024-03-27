import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/models/category_model.dart';

Future<List<CategoryModel>?> fetchCategories() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['categories'];
    List<CategoryModel> recipes =
        jsonData.map((element) => CategoryModel.fromJson(element)).toList();

    return recipes;
  } else {
    print('Home Service Error');
  }
  return null;
}
