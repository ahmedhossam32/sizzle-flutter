import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'data/meal_api.dart';
import 'data/meal_repository.dart';
import 'domain/category.dart';
import 'domain/meal.dart';
import 'designTokens/design_tokens.dart';

class MainScrollPage extends StatefulWidget {
  const MainScrollPage({super.key});

  @override
  State<MainScrollPage> createState() => _MainScrollPageState();
}

class _MainScrollPageState extends State<MainScrollPage> {
  late final MealRepository _mealRepository;
  late final Future<List<Category>> _categoriesFuture;
  late Future<List<Meal>> _mealsFuture;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final api = MealApi(dio);
    _mealRepository = MealRepository(api);

    _categoriesFuture = _mealRepository.getCategories();
    _mealsFuture = _mealRepository.getHomeFeed();
  }

  void _onCategorySelected(String category) {
    setState(() {
      if (_selectedCategory == category) {
        // Tapping the active category again clears the filter.
        _selectedCategory = null;
        _mealsFuture = _mealRepository.getHomeFeed();
      } else {
        _selectedCategory = category;
        _mealsFuture = _mealRepository.getMealsByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Header
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: DesignTokens.ink,
              ),
            ),
          ),

          // Categories Horizontal List View
          SizedBox(
            height: 52,
            child: FutureBuilder<List<Category>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(child: Text("Error: ${snapshot.error}")),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(child: Text("No categories found")),
                  );
                }

                final categoriesList = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    final category = categoriesList[index];
                    final isSelected = category.name == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: _buildCategoryChip(category, isSelected),
                    );
                  },
                );
              },
            ),
          ),

          // Popular Picks Header
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 12.0),
            child: Text(
              _selectedCategory ?? "Popular picks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: DesignTokens.ink,
              ),
            ),
          ),

          // Popular Picks Grid View
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<Meal>>(
              future: _mealsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No meals found"));
                }

                final meals = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: meals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.78, // Adjusted to fit image, spacing, name, area
                  ),
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return _buildMealCard(meal);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 24.0), // Bottom spacing for list scrolling comfort
        ],
      ),
    );
  }

  Widget _buildCategoryChip(Category category, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onCategorySelected(category.name),
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: isSelected ? DesignTokens.primary : Colors.white,
            borderRadius: BorderRadius.circular(30.0), // Rounded pill shape
            border: Border.all(
              color: isSelected
                  ? DesignTokens.primary
                  : const Color(0xFFF3E5DB), // Light beige border
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circular category thumbnail
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFF8F2),
                ),
                child: ClipOval(
                  child: Image.network(
                    category.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.fastfood,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isSelected ? Colors.white : DesignTokens.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0), // Smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Image + Favorite Heart Icon Overlay
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                    child: Image.network(
                      meal.thumbnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // Favorite Heart Button
                Positioned(
                  top: 12.0,
                  right: 12.0,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: DesignTokens.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Meal Name and Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: DesignTokens.ink,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  meal.area.isNotEmpty ? meal.area : (_selectedCategory ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}