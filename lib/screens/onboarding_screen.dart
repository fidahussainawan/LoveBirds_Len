// // onboarding_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import '../utils/constants.dart';
// import 'main_screen.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   final List<OnboardingData> _pages = [
//     OnboardingData(
//       title: 'Discover the World of Birds with AI',
//       description: 'Your AI-powered bird expert',
//       icon: Icons.pets,
//       color: AppColors.primaryGreen,
//     ),
//     OnboardingData(
//       title: 'Save Your Discoveries',
//       description: 'Keep track of all your bird sightings and build your personal collection',
//       icon: Icons.bookmark,
//       color: AppColors.lightGreen,
//     ),
//     OnboardingData(
//       title: 'Learn Bird Behavior',
//       description: 'Understand bird habits, habitats, and characteristics with detailed information',
//       icon: Icons.school,
//       color: AppColors.darkGreen,
//     ),
//     OnboardingData(
//       title: 'Get Started!',
//       description: 'Ready to identify your first bird?',
//       icon: Icons.camera_alt,
//       color: AppColors.primaryGreen,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Skip button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: _skipOnboarding,
//                   child: Text(
//                     'Skip',
//                     style: TextStyle(
//                       color: AppColors.textLight.withOpacity(0.7),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Page view
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 itemCount: _pages.length,
//                 itemBuilder: (context, index) {
//                   return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: const Duration(milliseconds: 375),
//                     child: SlideAnimation(
//                       verticalOffset: 50.0,
//                       child: FadeInAnimation(
//                         child: _buildOnboardingPage(_pages[index]),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Page indicators
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   _pages.length,
//                       (index) => Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     width: _currentPage == index ? 24 : 8,
//                     height: 8,
//                     decoration: BoxDecoration(
//                       color: _currentPage == index
//                           ? AppColors.primaryGreen
//                           : AppColors.grey,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Navigation buttons
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (_currentPage > 0)
//                     TextButton(
//                       onPressed: () {
//                         _pageController.previousPage(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       },
//                       child: const Text(
//                         'Back',
//                         style: TextStyle(
//                           color: AppColors.textLight,
//                           fontSize: 16,
//                         ),
//                       ),
//                     )
//                   else
//                     const SizedBox(width: 60),
//
//                   ElevatedButton(
//                     onPressed: _currentPage == _pages.length - 1
//                         ? _finishOnboarding
//                         : () {
//                       _pageController.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryGreen,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 16,
//                       ),
//                     ),
//                     child: Text(
//                       _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOnboardingPage(OnboardingData data) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Circular background with icon
//           Container(
//             width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   data.color,
//                   data.color.withOpacity(0.3),
//                 ],
//                 stops: const [0.3, 1.0],
//               ),
//             ),
//             child: Center(
//               child: _currentPage == _pages.length - 1
//                   ? _buildBirdIllustration()
//                   : Icon(
//                 data.icon,
//                 size: 80,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 48),
//
//           // Title
//           Text(
//             data.title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textLight,
//               height: 1.2,
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Description
//           Text(
//             data.description,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16,
//               color: AppColors.textLight.withOpacity(0.8),
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBirdIllustration() {
//     return Stack(
//       children: [
//         // Multiple bird silhouettes
//         Positioned(
//           top: 30,
//           left: 40,
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 60,
//           right: 50,
//           child: Container(
//             width: 35,
//             height: 35,
//             decoration: BoxDecoration(
//               color: Colors.yellow,
//               borderRadius: BorderRadius.circular(17.5),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 40,
//           left: 50,
//           child: Container(
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(22.5),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 50,
//           right: 40,
//           child: Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(19),
//             ),
//           ),
//         ),
//         Center(
//           child: Icon(
//             Icons.camera_alt,
//             size: 60,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _skipOnboarding() async {
//     await _finishOnboarding();
//   }
//
//   void _finishOnboarding() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isFirstLaunch', false);
//
//     if (mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const MainScreen()),
//       );
//     }
//   }
// }
//
// class OnboardingData {
//   final String title;
//   final String description;
//   final IconData icon;
//   final Color color;
//
//   OnboardingData({
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.color,
//   });
// }


// onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/constants.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Discover the World of Birds with AI',
      description: 'Your AI-powered bird expert',
      icon: Icons.pets,
      color: const Color(0xFF4CAF50), // AppColors.primaryGreen
    ),
    OnboardingData(
      title: 'Save Your Discoveries',
      description: 'Keep track of all your bird sightings and build your personal collection',
      icon: Icons.bookmark,
      color: const Color(0xFF8BC34A), // AppColors.lightGreen
    ),
    OnboardingData(
      title: 'Learn Bird Behavior',
      description: 'Understand bird habits, habitats, and characteristics with detailed information',
      icon: Icons.school,
      color: const Color(0xFF2E7D32), // AppColors.darkGreen
    ),
    OnboardingData(
      title: 'Get Started!',
      description: 'Ready to identify your first bird?',
      icon: Icons.camera_alt,
      color: const Color(0xFF4CAF50), // AppColors.primaryGreen
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // AppColors.backgroundColor
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _skipOnboarding(),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: const Color(0xFF757575).withOpacity(0.7), // AppColors.textLight
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildOnboardingPage(_pages[index]),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Page indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF4CAF50) // AppColors.primaryGreen
                          : const Color(0xFF9E9E9E), // AppColors.grey
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFF757575), // AppColors.textLight
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  ElevatedButton(
                    onPressed: _currentPage == _pages.length - 1
                        ? () => _finishOnboarding()
                        : () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50), // AppColors.primaryGreen
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular background with icon
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  data.color,
                  data.color.withOpacity(0.3),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
            child: Center(
              child: _currentPage == _pages.length - 1
                  ? _buildBirdIllustration()
                  : Icon(
                data.icon,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF757575), // AppColors.textLight
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF757575).withOpacity(0.8), // AppColors.textLight
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirdIllustration() {
    return Stack(
      children: [
        // Multiple bird silhouettes
        Positioned(
          top: 30,
          left: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: 50,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(17.5),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 50,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(22.5),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 40,
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(19),
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.camera_alt,
            size: 60,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _skipOnboarding() async {
    await _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}