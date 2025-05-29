import 'package:flutter/material.dart';


import 'page_welcome.dart';
import 'page_dining.dart';

class OnboardingRoomPage extends StatelessWidget {
  const OnboardingRoomPage({super.key});

  // Color palette
  static const Color primary = Color(0xFF580304);
  static const Color secondary = Color(0xFF763C3C);
  static const Color accent = Color(0xFFF6DFDF);
  static const Color background = Colors.white;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Title
              Text(
                'Find the perfect\nroom for your stay',
                style: TextStyle(
                  color: primary,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 76),
              // Bullet points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _BulletPoint(text: 'Real-time availability'),
                  _BulletPoint(text: 'Location-based search'),
                  _BulletPoint(text: 'Instant booking confirmation'),
                ],
              ),
              const SizedBox(height: 24),
              
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/onboarding/2.png',
                    fit: BoxFit.contain,
                    width: size.width * 1.6,
                    height: size.height * 0.68,
                  ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(isActive: false),
                  _buildIndicator(isActive: true),
                  _buildIndicator(isActive: false),
                  _buildIndicator(isActive: false),
                ],
              ),
              const SizedBox(height: 28),
              // Buttons
              Row(
                children: [
                  // Previous Button
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primary,
                        side: const BorderSide(color: secondary, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const WelcomePage()),
                        );
                      },
                      child: const Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Next Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const PageDining()),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: accent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Dot indicator builder
  static Widget _buildIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? secondary : accent,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// Bullet point widget
class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 8, color: Color(0xFF580304)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 19, 
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
