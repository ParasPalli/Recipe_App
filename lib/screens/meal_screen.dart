import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/services/meal_services.dart';
import 'package:recipe_app/services/random_service.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';

class MealScreen extends StatefulWidget {
  final String mealId;
  final String mealName;
  final bool random;
  const MealScreen({
    super.key,
    this.mealId = "",
    this.mealName = "",
    this.random = false,
  });

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          widget.mealName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await screenshotController
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((image) async {
                if (image != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/image.png').create();
                  await imagePath.writeAsBytes(image);

                  /// Share Plugin
                  // await Share.shareFiles([imagePath.path]);
                  shareFile(file: File(imagePath.path), subject: 'subject');
                }
              });
            },
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: FutureBuilder(
            future: widget.random
                ? fetchRandomMeal(widget.mealId)
                : fetchMeal(widget.mealId),
            builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading Section...
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                data["strMealThumb"],
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Text(
                                data["strMeal"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Instruction Section
                        const SizedBox(height: 20),
                        const Text(
                          "Instructions:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data["strInstructions"],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Ingridients...
                        const SizedBox(height: 20),
                        const Text(
                          "Ingridients:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(20, (index) {
                            return data["strIngredient${index + 1}"] != ""
                                ? RichText(
                                    text: TextSpan(
                                      text:
                                          '${data["strIngredient${index + 1}"]} ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '( ${data["strMeasure${index + 1}"]} )',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox();
                          }),
                        )
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
