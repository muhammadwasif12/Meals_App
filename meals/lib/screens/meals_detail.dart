import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealsDetailScreen extends ConsumerWidget {
  const MealsDetailScreen({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? "Meal added as a favorite"
                        : "Meal removed from favorite",
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.7, end: 1).animate(animation),
                  filterQuality: FilterQuality.high,
                  child: child,
                );
              },
            ),
          ),
        ], //
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 14),
            Text(
              'Ingrediants',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            for (final ingrediant in meal.ingredients)
              Text(
                ingrediant,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            SizedBox(height: 24),

            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            for (final step in meal.steps)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
