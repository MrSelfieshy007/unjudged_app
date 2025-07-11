import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:unjudged_now/ui/widgets/glass_morphism_card.dart';
import 'dart:async';
import 'package:unjudged_now/ui/screens/login_screen.dart';
import 'package:unjudged_now/ui/widgets/video_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/cosmic_background.mp4')
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginScreen(controller: _controller),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (_isVideoInitialized)
            VideoBackground(controller: _controller)
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          Center(
            child: GlassMorphismCard(
      color: Colors.white.withOpacity(0.1),
  height: 250,
  width: MediaQuery.of(context).size.width * 0.9,
  borderRadius: BorderRadius.circular(24),
  borderWidth: 1,
  borderColor: Colors.white.withOpacity(0.2),
  blur: 10,
  child: const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Unjudged Now',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Find your cosmic connection.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
