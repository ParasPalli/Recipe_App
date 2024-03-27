import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchMeal(String mealId) async {
  print(mealId);
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body)['meals'][0];
    // MealModel meal = MealModel.fromJson(jsonData);

    return jsonData;
  } else {
    print('Meal Service Error');
  }
  return null;
}
