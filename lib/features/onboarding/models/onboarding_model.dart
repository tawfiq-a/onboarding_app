class OnboardingModel {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  static List<OnboardingModel> onboardingData = [
    OnboardingModel(
      // Screen 1: Introduce syncing with nature's rhythm
      title: "Discover the beauty, one journey at a time.",
      description:
      "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.",
      imageUrl: 'assets/onboarding2.png',
    ),
    OnboardingModel(
      // Screen 2: Explain effortless and automatic syncing
      title: "Explore new horizons, one step at a time.",
      description:
      "Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.",
      imageUrl: 'assets/onboarding1.png',
    ),
    OnboardingModel(
      // Screen 3: Mention relaxation and unwinding
      title: "See the beauty, one journey at a time.",
      description:
      "Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.",
      imageUrl: 'assets/onboarding3.png',
    ),
  ];
}