import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchRandomMeal(String mealId) async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body)['meals'][0];
    return jsonData;
  } else {
    print('Meal Service Error');
  }
  return null;
}
