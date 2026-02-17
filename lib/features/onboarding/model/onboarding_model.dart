class OnboardingModel {
  final String title;
  final String description;
  final String imagePath; // Local asset or network path
  final String? highlightText; // For "Real Situations" blue text

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    this.highlightText,
  });
}