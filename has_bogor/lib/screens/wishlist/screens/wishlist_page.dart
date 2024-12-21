import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/screens/create_payment.dart';
import 'package:has_bogor/screens/wishlist/models/wishlist_entry.dart';
import 'package:has_bogor/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:has_bogor/screens/penyimpanan/models/katalog_model.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Future<List<WishlistItem>> fetchWishlist(CookieRequest request) async {
    try {
      // Gunakan 10.0.2.2 untuk emulator Android
      final response = await request.get('http://10.0.2.2:8000/wishlist/json/');
      
      if (response == null) return [];
      
      WishlistModels wishlist = WishlistModels.fromJson({
        "data": response is List ? response : response["data"] ?? []
      });
      
      return wishlist.data;
    } catch (e) {
      print("Error fetching wishlist: $e");
      return [];
    }
  }

  Future<void> removeWishlist(CookieRequest request, int itemId) async {
    try {
      await request.post(
        'http://10.0.2.2:8000/wishlist/api/remove/$itemId/',
        {},
      );
      setState(() {}); // Refresh the list
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Berhasil dihapus dari wishlist!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal menghapus dari wishlist."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.indigo[900],
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<WishlistItem>>(
          future: fetchWishlist(request),
          builder: (context, AsyncSnapshot<List<WishlistItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              print("Error in snapshot: ${snapshot.error}");
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Wishlist Anda Kosong",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Kembali ke Home'),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.black.withOpacity(0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/sangkuriang.jpeg',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                DateFormat('dd MMM').format(item.addedAt),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.desc,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                    ),
                                    onPressed: () {
                          // Konversi WishlistItem ke Katalog untuk CreatePaymentScreen
                          final katalog = Katalog(
                              id: 0,        // Default id karena tidak ada di WishlistItem
                              nama: item.name,
                              kategori: 1,  // Default kategori karena tidak ada di WishlistItem
                              harga: 0.0,   // Default harga karena tidak ada di WishlistItem
                              deskripsi: item.desc,
                              toko: "Unknown", // Default toko karena tidak ada di WishlistItem
                          );
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePaymentScreen(
                                      katalog: katalog,
                                  ),
                              ),
                          );
                      },
                                                          child: const Text(
                                      'Beli',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  onPressed: () => removeWishlist(request, item.id),
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}