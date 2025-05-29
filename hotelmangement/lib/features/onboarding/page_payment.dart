import 'package:flutter/material.dart';
import 'page_dining.dart';
import 'package:hotelmangement/features/auth/auth.dart';

class PagePayment extends StatelessWidget {
  const PagePayment({super.key});

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
                  'Secure Payments\n& Track Your Bookings',
                  style: const TextStyle(
                    color: primary,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                // Image
                Image.asset(
                  'assets/onboarding/4.png',
                  fit: BoxFit.contain,
                  width: size.width * 1.4,
                  height: size.height * 0.5,
                ),
                const SizedBox(height: 24),
                // Bullet points
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _BulletPoint(text: 'Pay via Visa, MasterCard'),
                    _BulletPoint(text: 'View transaction history'),
                    _BulletPoint(text: 'Get payment confirmations'),
                  ],
                ),
                const Spacer(),
                // dot indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(isActive: false),
                    _dot(isActive: false),
                    _dot(isActive: false),
                    _dot(isActive: true),
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
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const PageDining()),
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
                    // Get Started Button
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
                            MaterialPageRoute(builder: (_) => const AuthScreen()),
                          );
                        },
                        child: const Text(
                          'Get Started',
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
