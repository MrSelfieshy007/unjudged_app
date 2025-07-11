import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unjudged_now/ui/widgets/glass_morphism_card.dart';
import 'package:video_player/video_player.dart';
import 'package:unjudged_now/ui/screens/gender_selection_screen.dart';
import 'package:unjudged_now/ui/widgets/video_background.dart';
import 'package:unjudged_now/core/services/supabase_service.dart';

class LoginScreen extends StatefulWidget {
  final VideoPlayerController controller;
  const LoginScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          VideoBackground(controller: widget.controller),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: GlassMorphismCard(
      padding: const EdgeInsets.all(24.0),
  color: Colors.white.withOpacity(0.1),
  height: 450,
  width: MediaQuery.of(context).size.width * 0.9,
  borderRadius: BorderRadius.circular(24),
  borderWidth: 1,
  borderColor: Colors.white.withOpacity(0.2),
  blur: 15,
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue your journey.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildAuthButton(
                      iconPath: 'assets/icons/google_logo.svg',
                      text: 'Sign in with Google',
                      onPressed: () async {
                        final supabaseService = SupabaseService();
                        await supabaseService.signInWithGoogle(context);
                        // Navigation will be handled by auth state listener in a real app
                        // For now, we navigate optimistically.
                        if (mounted) {
                           Navigator.of(context).push(MaterialPageRoute(builder: (_) => GenderSelectionScreen(controller: widget.controller)));
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildAuthButton(
                      iconData: Icons.email_outlined,
                      text: 'Sign in with Email',
                      onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (_) => GenderSelectionScreen(controller: widget.controller)));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildAuthButton(
                      iconData: Icons.phone_outlined,
                      text: 'Sign in with Phone',
                      onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (_) => GenderSelectionScreen(controller: widget.controller)));
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ", style: TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton({String? iconPath, IconData? iconData, required String text, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: iconPath != null
          ? SvgPicture.asset(iconPath, height: 22, width: 22)
          : Icon(iconData, color: Colors.white),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.15),
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }
}
