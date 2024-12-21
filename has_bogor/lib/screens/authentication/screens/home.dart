import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:has_bogor/widgets/left_drawer.dart';
import 'product_card.dart';
import 'package:has_bogor/screens/promo/promo_screens.dart';
import 'package:has_bogor/screens/ulasan/screens/show_ulasan_page.dart';
import 'package:has_bogor/screens/wishlist/screens/wishlist_page.dart';
import 'package:has_bogor/screens/pembayaran/screens/create_payment.dart';
import '../../penyimpanan/models/katalog_model.dart';
import '../../penyimpanan/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final String userName = "Bogorlovers";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  Future<List<Katalog>> fetchKatalog() async {
    try {
      final items = await apiService.fetchKatalogItems();
      return items;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      drawer: const LeftDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomePage(),
          _buildReviewPage(),
          _buildWishlistPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo[900]!, Colors.blueGrey[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo[900]!, Colors.blueGrey[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: "Review",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo[900]!, Colors.blueGrey[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildPromoSection(),
            const SizedBox(height: 20),
            _buildKatalogSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back, $userName!",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Explore the best products for you",
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for products...",
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PromoScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.yellow[700],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_offer, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Big Sale! Up to 50% off on selected products!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/promo.jpeg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildKatalogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Katalog Produk",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<Katalog>>(
          future: fetchKatalog(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return ProductCard(
                    katalog: item,
                    onBeli: () {
                      // Navigasi ke halaman pembayaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePaymentScreen(katalog: item),
                        ),
                      );
                    },
                    onWishlist: () {
                      // Navigasi ke halaman wishlist
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishlistPage(),
                        ),
                      );
                    },
                    onReview: () {
                      // Navigasi ke halaman review
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewScreen(),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const Center(
              child: Text(
                "Tidak ada produk tersedia",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewPage() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReviewScreen(),
          ),
        );
      },
      child: const Center(
        child: Text(
          "Review Page - Tap to view reviews",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildWishlistPage() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WishlistPage(),
          ),
        );
      },
      child: const Center(
        child: Text(
          "Wishlist Page - Tap to view wishlist",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}