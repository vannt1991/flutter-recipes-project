// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_future.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesHash() => r'fc07688808a4f3690d1ab053b253c7ed725dc3c4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef RecipesRef = AutoDisposeFutureProviderRef<List<RecipeEntity>?>;

/// See also [recipes].
@ProviderFor(recipes)
const recipesProvider = RecipesFamily();

/// See also [recipes].
class RecipesFamily extends Family<AsyncValue<List<RecipeEntity>?>> {
  /// See also [recipes].
  const RecipesFamily();

  /// See also [recipes].
  RecipesProvider call({
    required int movieId,
  }) {
    return RecipesProvider(
      movieId: movieId,
    );
  }

  @override
  RecipesProvider getProviderOverride(
    covariant RecipesProvider provider,
  ) {
    return call(
      movieId: provider.movieId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipesProvider';
}

/// See also [recipes].
class RecipesProvider extends AutoDisposeFutureProvider<List<RecipeEntity>?> {
  /// See also [recipes].
  RecipesProvider({
    required this.movieId,
  }) : super.internal(
          (ref) => recipes(
            ref,
            movieId: movieId,
          ),
          from: recipesProvider,
          name: r'recipesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipesHash,
          dependencies: RecipesFamily._dependencies,
          allTransitiveDependencies: RecipesFamily._allTransitiveDependencies,
        );

  final int movieId;

  @override
  bool operator ==(Object other) {
    return other is RecipesProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
