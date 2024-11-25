import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Configura el AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Configura una animación de opacidad
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Inicia la animación y navega a la siguiente pantalla
    _controller.forward().then((_) {
      Navigator.pushReplacementNamed(context, '/login'); // Cambiar a la pantalla de login
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
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Imagen del ojo
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/images/eye.png',
                width: 300,
                height: 300,
              ),
            ),
            // Imagen del texto (aparece al terminar la animación del ojo)
            FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
                  .animate(_controller),
              child: Image.asset(
                'assets/images/title.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}