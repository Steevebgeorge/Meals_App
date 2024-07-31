import 'package:flutter/material.dart';
import 'package:meals/data/dummydata.dart';
import 'package:meals/models/catagory.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/catagory_grid.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key, required this.availablemeals});

  final List<Meal> availablemeals;

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCatagory(BuildContext context, Category category) {
    final filteredMeals = widget.availablemeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            ...availableCategories.map(
              (category) => CategoryGridItem(
                catagory: category,
                onCatagorySelect: () {
                  _selectCatagory(context, category);
                },
              ),
            )

            // same as below

            //
            // for (final category in availableCategories)
            //   CategoryGridItem(
            //     catagory: category,
            //     onCatagorySelect: () {
            //       _selectCatagory(context, category);
            //     },
            //   )
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.05),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            ));
  }
}
