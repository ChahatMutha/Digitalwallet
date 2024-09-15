import 'package:digiwallet/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:digiwallet/widgets/onboarding_card.dart';

class Journey extends StatefulWidget {
  const Journey({super.key});

  @override
  State<Journey> createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  final List<Widget> _onboardingPages = [];

  @override
  Widget build(BuildContext context) {
    // Initialize onboarding pages inside the build method or initState
    if (_onboardingPages.isEmpty) {
      _onboardingPages.addAll([
        OnboardingCard(
          image: "assets/images/welcome.png",
          title: 'Welcome to DigiWallet!',
          description:
              'Introducing the seamless transaction platform and providing an overview of the application\'s purpose.',
          buttonText: 'Next',
          onPressed: (context) {
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
        ),
        OnboardingCard(
          image: "assets/images/onboard3.jpg",
          title: 'Create an Account and Choose a Wallet',
          description:
              'Directing users to create an account and select a wallet that fits their interests and needs.',
          buttonText: 'Next',
          onPressed: (context) {
            _pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
        ),
        OnboardingCard(
          image: "assets/images/onboard2.png",
          title: 'Seamless Transaction',
          description:
              'Emphasizing the benefits of exchanging transaction seamlessly that can be tailored to users\' personal needs .',
          buttonText: 'Done',
          onPressed: (context) {
            navigateToLogin();
          },
        ),
      ]);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onboardingPages,
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingPages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Theme.of(context).colorScheme.secondary,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
