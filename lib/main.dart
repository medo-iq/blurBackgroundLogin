import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradientBackground(),
    );
  }
}

class GradientBackground extends StatefulWidget {
  const GradientBackground({super.key});

  @override
  _GradientBackgroundState createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    _animation1 = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _animation2 = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.black, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 + sin(_animation1.value) * 60,
                    top: MediaQuery.of(context).size.height / 3 + cos(_animation1.value) * 60,
                    child: _buildBlurCircle(110),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 + cos(_animation2.value) * 30,
                    bottom: MediaQuery.of(context).size.height / 5 + sin(_animation2.value) * 30,
                    child: _buildBlurCircle(150),
                  ),
                ],
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome Ahmed!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This is Demo Screen ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(Icons.person, 'Username'),
                  const SizedBox(height: 16),
                  _buildTextField(Icons.lock, 'Password'),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(FontAwesome.google),
                      const SizedBox(width: 20),
                      _buildSocialIcon(FontAwesomeIcons.github),
                      const SizedBox(width: 20),
                      _buildSocialIcon(FontAwesome.apple),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.35),
            blurRadius: 50.0,
            spreadRadius: 30.0,
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22.0, sigmaY: 22.0),
          child: Container(
            color: Colors.white.withOpacity(0),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }
}
