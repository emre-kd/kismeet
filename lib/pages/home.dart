import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isSearching = false;

  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _anim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (isSearching) {
      _controller.stop();
      _controller.reset();
      setState(() => isSearching = false);
      return;
    }

    setState(() => isSearching = true);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFFFF085B),
                    const Color(0xFF6A11CB),
                    _anim.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF7597DE),
                    const Color(0xFFDA22FF),
                    _anim.value,
                  )!,
                ],
              ),
            ),
            child: Center(
              child: MouseRegion(
                onEnter: (_) {
                  if (!isSearching) {
                    setState(() => isHover = true);
                  }
                },
                onExit: (_) => setState(() => isHover = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.translationValues(
                    0,
                    isHover && !isSearching ? -14 : 0,
                    0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(
                          isSearching ? 0.45 : 0.25,
                        ),
                        blurRadius: isHover ? 35 : 25,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _onTap,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (isSearching) ...[
                          _PulseRing(animation: _anim, size: 190),
                          _PulseRing(
                            animation: ReverseAnimation(_anim),
                            size: 190,
                          ),
                        ],
                        Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              radius: 0.85 + _anim.value,
                              colors: const [
                                Color(0xFFFF4ECD),
                                Color(0xFF7F00FF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration:
                                  const Duration(milliseconds: 300),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeIn,
                              child: Text(
                                isSearching
                                    ? 'aranıyor...'
                                    : 'Kismeet',
                                key: ValueKey(isSearching),
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      isSearching ? 15 : 20,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.2,
                                  color: Colors.white,
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
            ),
          );
        },
      ),
    );
  }
}

/// Elektro / soundpad hissi veren halka
class _PulseRing extends StatelessWidget {
  final Animation<double> animation;
  final double size;

  const _PulseRing({
    required this.animation,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Container(
          width: size + animation.value * 90,
          height: size + animation.value * 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.purpleAccent.withOpacity(
                1 - animation.value,
              ),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}
