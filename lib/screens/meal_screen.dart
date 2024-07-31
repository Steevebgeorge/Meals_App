import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/mealsdetails_screen.dart';
import 'package:meals/widgets/mealitem.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(
      {super.key,
      this.title,
      required this.meals,
      });
  final String? title;
  final List<Meal> meals;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailsScreem(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Meals is Empty',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select  different Catagory',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItemCard(
          meal: meals[index],
          onselectMeal: (meal) {
            onSelectMeal(context, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
