import 'package:flutter/material.dart';
import 'page_find_room.dart';
import 'page_payment.dart';

class PageDining extends StatelessWidget {
  const PageDining({super.key});

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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Heading
                Text(
                  'Order meals and\nexplore dining\noptions',
                  style: const TextStyle(
                    color: primary,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 68),
                // Bullet points
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _BulletPoint(text: 'Book dine-in tables'),
                    _BulletPoint(text: 'Room service at your fingertips'),
                    _BulletPoint(text: 'View menus and pricing'),
                  ],
                ),
                const SizedBox(height: 20),
                // Image
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(
                      'assets/onboarding/3.png',
                      fit: BoxFit.contain,
                      width: size.width * 4.0,
                      height: size.height * 2.0,
                    ),
                  ),
                ),
                // -dot indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(isActive: false),
                    _dot(isActive: false),
                    _dot(isActive: true),
                    _dot(isActive: false),
                  ],
                ),
                const SizedBox(height: 32),
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
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const OnboardingRoomPage()),
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
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const PagePayment()),
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dot indicator
  static Widget _dot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 10 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black.withOpacity(0.8) : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}


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
            padding: EdgeInsets.only(top: 7.0),
            child: Icon(Icons.circle, size: 8, color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
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
