import 'package:flutter/material.dart';
import 'package:meals/models/catagory.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.catagory,
    required this.onCatagorySelect,
  });
  final Category catagory;
  final void Function() onCatagorySelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCatagorySelect,
      splashColor: Theme.of(context).splashColor,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              catagory.color.withOpacity(0.3),
              catagory.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          catagory.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
