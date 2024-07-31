import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favourites_provider.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:meals/screens/filterscreen.dart';
import 'package:meals/screens/gridlist_screen.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _onSelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSelectDrawer(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = ref.watch(filteredMealsProvider);

    Widget activePage = GridScreen(
      availablemeals: availablemeals,
    );
    var activepagetitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealScreen(
        meals: favouriteMeals,
      );
      activepagetitle = 'your favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: MainDrawer(onSelectDrawerItem: _onSelectDrawer),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
