import 'package:flutter/material.dart';
import 'package:mealApp/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = "/meal-details";

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailsScreen(this.isFavorite, this.toggleFavorite);

  Widget buildSectionTitle(String text) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
    );
  }

  Widget buildCardList(data, int size) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (ctx, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data[index]),
          ),
        ),
        itemCount: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle("Ingredients"),
          buildCardList(meal.ingredients, meal.ingredients.length),
          buildSectionTitle("Steps"),
          buildCardList(meal.steps, meal.steps.length),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(meal.id) ? Icon(Icons.star, color: Colors.yellow,) : Icon(Icons.star_border, color: Colors.white24),
        onPressed: () { toggleFavorite(meal.id); },
      ),
    );
  }
}
