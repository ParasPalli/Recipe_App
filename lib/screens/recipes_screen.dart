import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipes_model.dart';
import 'package:recipe_app/screens/meal_screen.dart';
import 'package:recipe_app/services/recipes_services.dart';

class RecipesScreen extends StatefulWidget {
  final String category;
  const RecipesScreen({super.key, required this.category});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Colors.teal,
        title: Text(
          widget.category,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onSearch: (value) {
          setState(() {
            filter = value;
          });
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchReceipes(widget.category),
          builder: (context, AsyncSnapshot<List<RecipesModel>?> snapshot) {
            if (snapshot.hasData) {
              List<RecipesModel> data = snapshot.data!;

              if (filter.isNotEmpty) {
                data = data
                    .where((element) => element.strMeal.startsWith(filter))
                    .toList();
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealScreen(
                            mealId: data[index].idMeal,
                            mealName: data[index].strMeal,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              data[index].strMealThumb,
                              height: 80,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              data[index].strMeal,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          },
        ),
      ),
    );
  }
}
