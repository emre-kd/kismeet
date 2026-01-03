import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF1A6E),
              Color(0xFF9C27B0),
              Color(0xFF673AB7),
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // PageView - slaytlar
              PageView(
                controller: _controller,
                onPageChanged: (index) => setState(() => currentIndex = index),
                children: const [
                  _ModernSlide(
                    illustration: Icons.phone_android_rounded,
                    title: "Anında Keşfet",
                    description:
                        "Bulunduğun yerdeki insanlarla eşsiz, anonim anlar yaşa.",
                  ),
                  _ModernSlide(
                    illustration: Icons.timer_outlined,
                    title: "Zamanın Peşinde",
                    description:
                        "Her eşleşme sınırlı süreli. Hızlı ol, fırsat kaçmasın!",
                  ),
                  _ModernSlide(
                    illustration: Icons.lock_outline_rounded,
                    title: "Gizli & Gerçek",
                    description:
                        "Kimlik göstermeden sadece anı yaşa, gerisi sana kalmış.",
                  ),
                ],
              ),

              // Atla butonu
              Positioned(
                top: 16,
                right: 20,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white70,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Atla',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // Bottom Area → Sadece indicator + son slaytta Başla
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indicator noktaları (her zaman görünür)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: currentIndex == index ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // SADECE SON SLAYTTA "Başla" butonu
                    if (currentIndex == 2)
                      GestureDetector(
                        onTap: _finishOnboarding,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B6B), Color(0xFFFF4081)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF4081).withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Text(
                            'Kısmeet !',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _ModernSlide sınıfı aynı kaldı
class _ModernSlide extends StatelessWidget {
  final IconData illustration;
  final String title;
  final String description;

  const _ModernSlide({
    required this.illustration,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.05),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
            child: Icon(
              illustration,
              size: 110,
              color: Colors.white.withOpacity(0.95),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.82),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}