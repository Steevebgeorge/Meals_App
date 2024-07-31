import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super(
          {
            Filter.glutenfree: false,
            Filter.lactosefree: false,
            Filter.vegetarian: false,
            Filter.vegan: false,
          },
        );
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meals) {
    if (activeFilters[Filter.glutenfree]! && !meals.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactosefree]! && !meals.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meals.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meals.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
