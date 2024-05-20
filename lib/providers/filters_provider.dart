import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends Notifier<Map<Filter, bool>> {
  @override
  Map<Filter, bool> build() => {
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      };

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }

  List<Meal> getFilteredMeals() {
    final meals = ref.watch(mealsProvider);
    return meals.where((meal) {
      if (state[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (state[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (state[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (state[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }
}

final filtersProvider =
    NotifierProvider<FiltersNotifier, Map<Filter, bool>>(FiltersNotifier.new);
