import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Impor dari animated_text_kit
import 'package:has_bogor/screens/authentication/screens/login.dart';
import 'package:has_bogor/screens/authentication/screens/register.dart';

void main() {
  runApp(const WelcomePage());
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Animasi gambar slide otomatis
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (_pageController.hasClients) {
      // Meneruskan scroll otomatis setiap 3 detik
      _pageController.animateToPage(
        (_currentPage + 1) % 3, // Menjaga agar terus berulang dari slide 1 ke 3 dan kembali ke 1
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = (_currentPage + 1) % 3; // Update halaman aktif
      });
      Future.delayed(const Duration(seconds: 3), _autoScroll); // Mengulang proses
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1D1E3C), Color(0xff004F8C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            children: <Widget>[
              // Teks "Welcome to Has Bogor!" di tengah atas
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: TyperAnimatedTextKit(
                  text: const ["Welcome to Has Bogor!"],
                  speed: const Duration(milliseconds: 100),
                  textStyle: const TextStyle(
                    fontFamily: 'Cinzel Decorative',
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),

              // Slide show otomatis di bawah teks
              Container(
                height: keyboardOpen ? 0 : MediaQuery.of(context).size.height / 3, // Mengatur tinggi slide lebih kecil
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    // Slide 1
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), // Rounded corner
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slide1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Slide 2
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), // Rounded corner
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slide2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Slide 3
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), // Rounded corner
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slide3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Keterangan dan tombol Login, Register di bawah slide
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    // Keterangan Has Bogor
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Has Bogor is a platform for you to find the best products in the Bogor area.\nFind deals and make your shopping experience amazing!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Login
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: const Size(double.infinity, 60), // Mengatur ukuran tombol lebih kecil
                        shadowColor: Colors.black.withOpacity(0.2),
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Menambah jarak lebih kecil antar tombol

                    // Tombol Register
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: Colors.indigo.shade900,
                          ),
                        ),
                        minimumSize: const Size(double.infinity, 60), // Mengatur ukuran tombol lebih kecil
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff3992C6),
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
