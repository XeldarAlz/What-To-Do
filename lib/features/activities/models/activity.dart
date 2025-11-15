class Activity {
  const Activity({
    required this.label,
    required this.query,
    this.emoji,
    this.imageQuery,
  });

  final String label;
  final String query;
  final String? emoji;
  final String? imageQuery;

  String get imageSearchQuery => imageQuery ?? query;
}

