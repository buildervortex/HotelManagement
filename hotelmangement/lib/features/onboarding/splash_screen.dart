import 'package:flutter/material.dart';
import 'package:hotelmangement/features/onboarding/page_welcome.dart';

class SplashScreen extends StatefulWidget {
  /// Callback after splash is done, or you can navigate inside this widget.
  final VoidCallback? onSplashFinished;

  const SplashScreen({Key? key, this.onSplashFinished}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for fade and scale animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade animation from 0 (transparent) to 1 (opaque)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Scale animation from 0.8x to 1x size
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Start animations
    _controller.forward();

    // After, navigate or call callback
    Future.delayed(const Duration(seconds: 6), () {
      if (widget.onSplashFinished != null) {
        widget.onSplashFinished!();
      } else {
        // Default navigation to HomeScreen if no callback provided
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F9),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/onboarding/splash.png', 
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

/// Placeholder HomeScreen widget to navigate after splash
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF580304),
        title: const Text('Hotel Reservation'),
      ),
      body: Center(
        child: Text(
          'Welcome to Hotel Reservation App',
          style: TextStyle(
            color: const Color(0xFF580304),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
