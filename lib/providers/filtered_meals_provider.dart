import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';

class FilteredMealsNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }
}

final filteredMealsProvider =
    NotifierProvider<FilteredMealsNotifier, List<Meal>>(
        FilteredMealsNotifier.new);
