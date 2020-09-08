import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import 'package:mealApp/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Meal App")),
      body: GridView(
        padding: EdgeInsets.all(10),
        children: DUMMY_CATEGORIES.map((catData) =>
          CategoryItem(catData.id, catData.title, catData.color)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
