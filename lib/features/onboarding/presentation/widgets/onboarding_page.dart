import 'package:flutter/material.dart';
import '../screens/onboarding_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _index = 0;

  void _next() {
    if (_index < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _back() {
    if (_index > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        children: [
          /// Screen 1
          OnboardingIntroScreen(onNext: _next),

          /// Screen 2
          OnboardingImageScreen(
            image: 'assets/images/onboarding2.jpg',
            overlayOpacity: 0.55,
            bottomCard: OnboardingBottomCard(
              title: 'Discover Movies',
              description:
              'Explore a vast collection of movies in all qualities and genres.Find Your next favorite film with ease',
              primaryText: 'Next',
              onPrimary: _next,
              heightFactor:0.35,
              maxDescriptionLines: 3,
            ),
          ),

          /// Screen 3
          OnboardingImageScreen(
            image: 'assets/images/onboarding3.jpg',
            overlayOpacity: 0.7,
            bottomCard: OnboardingBottomCard(
              title: 'Explore All Genres',
              description:
              'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
              primaryText: 'Next',
              onPrimary: _next,
              onBack: _back,
              heightFactor: 0.45,
              maxDescriptionLines: 3,
            ),
          ),

          /// Screen 4
          OnboardingImageScreen(
            image: 'assets/images/onboarding4.jpg',
            overlayOpacity: 0.65,
            bottomCard: OnboardingBottomCard(
              title: 'Create Watchlists',
              description:
              'Save movies to your watchlist to keep\n track of what you want to watch next.\n Enjoy films in various qualities and \n genres.',
              primaryText: 'Next',
              onPrimary: _next,
              onBack: _back,
              titleSize:28,
              descriptionSize:19,
              heightFactor: 0.46,
              maxDescriptionLines: 4,
            ),
          ),

          /// Screen 5
          OnboardingImageScreen(
            image: 'assets/images/onboarding5.jpg',
            overlayOpacity: 0.75,
            bottomCard: OnboardingBottomCard(
              title: 'Rate, Review, and Learn',
              description:
              "Share your thoughts on the movies\n you've watched. Dive deep into film\n details and help others discover great\n movies with your reviews.",
              primaryText: 'Next',
              onPrimary: _next,
              onBack: _back,
              heightFactor: 0.48,
              maxDescriptionLines: 4,
            ),
          ),

          /// Screen 6
          OnboardingImageScreen(
            image: 'assets/images/onboarding6.jpg',
            overlayOpacity: 0.6,
            bottomCard: OnboardingBottomCard(
              title: 'Start Watching Now',
              primaryText: 'Finish',

              onPrimary: () {
                // TODO: Navigate to Home
              },
              onBack: _back,
            ),
          ),
        ],
      ),
    );
  }
}