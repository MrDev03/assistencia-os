import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'custom_widgets/elevated_button.dart';

class PremiumThankYouWidget extends StatefulWidget {
  final VoidCallback onContinue;

  const PremiumThankYouWidget({
    super.key,
    required this.onContinue,
  });

  @override
  State<PremiumThankYouWidget> createState() => _PremiumThankYouWidgetState();
}

class _PremiumThankYouWidgetState extends State<PremiumThankYouWidget>
    with TickerProviderStateMixin {

  late AnimationController _scaleController;
  late AnimationController _fadeController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0)
        .animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    // Inicia animações
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Confetes Lottie (arquivo grátis)
                  SizedBox(
                    height: 100,
                    child: Lottie.asset(
                      "assets/images/Thanks.json",
                      repeat: false,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Muito obrigado!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Sua assinatura Premium está ativa.\nAgora você desbloqueou todos os recursos! 🎉",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Informação Importante!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Text(
                    "Sua assinatura fica vinculada a sua conta google. Para sincronizar dados entre dispositivos, todos precisam está com a mesma conta google deste aparelho.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                  ),


                  const SizedBox(height: 25),

                  CustomElevatedButton(
                    label: "Continuar",
                    sizeLabel: 18,
                    click: widget.onContinue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
