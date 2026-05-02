// lib/domain/recipes.dart

enum MediaType { image, video }

class Recipe {
  final String id; // we'll generate simple ids like "r1", "r2"...
  final String? author;
  final String title;
  final String description;
  final String prepTime;
  final double rate;
  final String url;
  final MediaType type; // either image or video.
  String? thumbnailUrl;

  bool isSaved = false;
  Recipe({
    required this.id,
    this.author,
    required this.title,
    required this.description,
    required this.prepTime,
    required this.rate,
    required this.url,
    required this.type,
    this.thumbnailUrl,
  });
}