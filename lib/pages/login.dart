import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAnonymousSelected = false;

  final _nameController = TextEditingController();
  int? _selectedAge;
  String? _selectedGender;

  final List<String> _genders = ['Erkek', 'Kadın'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
          child: Column(
            children: [
              // Üst alan - daha kompakt
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.25),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'Hoş Geldin!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hemen keşfe başla',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Ana içerik - Expanded olmadan, doğal yükseklik
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Firebase giriş
                        _ActionButton(
                          text: 'Telefon / Google ile Giriş Yap',
                          isFilled: true,
                          onPressed: () {
                            // TODO: Firebase Auth
                          },
                        ),

                        const SizedBox(height: 16),

                        // Anonim buton
                        _ActionButton(
                          text: _isAnonymousSelected
                              ? 'Anonim Girişi Kapat'
                              : 'Anonim Olarak Devam Et',
                          isFilled: false,
                          onPressed: () {
                            setState(() => _isAnonymousSelected = !_isAnonymousSelected);
                          },
                        ),

                        if (_isAnonymousSelected) ...[
                          const SizedBox(height: 28),

                          Text(
                            'Son bir adım...',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 24),

                          _ModernTextField(
                            controller: _nameController,
                            label: 'İsim / Takma Ad',
                            icon: Icons.person_outline_rounded,
                          ),

                          const SizedBox(height: 24),

                          // Yaş slider - daha kompakt
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Yaşınız',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _selectedAge?.toString() ?? '—',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF1A6E),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 5,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                                  activeTrackColor: const Color(0xFFFF1A6E),
                                  inactiveTrackColor: Colors.grey[300],
                                  thumbColor: Colors.white,
                                ),
                                child: Slider(
                                  value: (_selectedAge ?? 25).toDouble(),
                                  min: 18,
                                  max: 80,
                                  divisions: 62,
                                  label: (_selectedAge ?? 25).toString(),
                                  onChanged: (v) => setState(() => _selectedAge = v.round()),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Cinsiyet chips
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cinsiyet',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: _genders.map((gender) {
                                  final selected = _selectedGender == gender;
                                  return GestureDetector(
                                    onTap: () => setState(() => _selectedGender = gender),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? const Color(0xFFFF1A6E)
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        gender,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: selected ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          _ActionButton(
                            text: 'Başlayalım',
                            isFilled: true,
                            onPressed: () {
                              if (_nameController.text.trim().isEmpty ||
                                  _selectedAge == null ||
                                  _selectedGender == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
                                );
                                return;
                              }
                              // TODO: Anonim kayıt + devam
                            },
                          ),
                        ],

                        const SizedBox(height: 20),
                        Text(
                          'Anonim modda bazı özellikler sınırlı olabilir.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Yardımcı modern buton widget'ı
class _ActionButton extends StatelessWidget {
  final String text;
  final bool isFilled;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.text,
    required this.isFilled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: isFilled
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF1A6E),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                text,
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF1A6E), width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF1A6E),
                ),
              ),
            ),
    );
  }
}

// Modern TextField (öncekiyle aynı)
class _ModernTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const _ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFFFF1A6E), size: 22),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    );
  }
}