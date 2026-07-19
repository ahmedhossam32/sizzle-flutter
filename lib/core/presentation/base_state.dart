import 'package:equatable/equatable.dart';

// Reference shape only — not a real state class. Every feature Cubit
// (e.g. MealCubit, RecipeDetailCubit) will define its own single state
// class shaped like this one (e.g. MealState, RecipeDetailState) instead
// of separate Loading/Success/Error subclasses: one immutable class with
// isLoading/data/errorMessage fields, emitted anew via copyWith on each
// transition. This is the MVI-style single-state-class discipline the
// presentation layer will follow.
class ExampleFeatureState<T> extends Equatable {
  const ExampleFeatureState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
  });

  final bool isLoading;
  final T? data;
  final String? errorMessage;

  ExampleFeatureState<T> copyWith({
    bool? isLoading,
    T? data,
    String? errorMessage,
  }) {
    return ExampleFeatureState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
