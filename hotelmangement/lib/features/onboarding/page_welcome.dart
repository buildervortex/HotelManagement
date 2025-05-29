import 'package:flutter/material.dart';
import 'page_find_room.dart'; 

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Spacer
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Relax \nReconnect \nRecharge',
                        style: TextStyle(
                          color: primary,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Discover handpicked stays for your perfect getaway.',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 19,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Image.asset(
                      'assets/onboarding/1.png',
                      fit: BoxFit.contain,
                      width: size.width * 0.8,
                      height: size.height * 0.4,
                    ),
                  ),
                ),

                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIndicator(isActive: true),  // First dot active
                    _buildIndicator(isActive: false),
                    _buildIndicator(isActive: false),
                    _buildIndicator(isActive: false),
                  ],
                ),

                // Next Button
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingRoomPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: accent,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({bool isActive = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? secondary : accent,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
