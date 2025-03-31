import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); //initialize empty fav meals list

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealisFavorite = state.contains(
      meal,
    ); //it checks meal is already exist in favorite list or not.

    if (mealisFavorite) {
      //if already exist then if statement run for remove this meal

      state =
          state
              .where((m) => m.id != meal.id)
              .toList(); //it remove specific meal from favlist i.e in fav list id=2 already exist and then user
      // meal id also 2 then condition is 2 !=2  condition false
      // it means return false other wise other meals add in fav list

      return false;
    } else {
      //if not exist then if statement run for add this meal
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });
