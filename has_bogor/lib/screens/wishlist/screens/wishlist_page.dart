import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/screens/create_payment.dart';
import 'package:has_bogor/screens/wishlist/models/wishlist_entry.dart';
import 'package:has_bogor/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
 // In your WishlistPage widget, replace the fetchWishlist function with:
Future<List<WishlistItem>> fetchWishlist(CookieRequest request) async {
  try {
    final response = await request.get('http://127.0.0.1:8000/wishlist/json/');
    
    // If response is null or empty, return empty list
    if (response == null) return [];
    
    // Parse the response
    WishlistModels wishlist = WishlistModels.fromJson({
      "data": response is List ? response : response["data"] ?? []
    });
    
    return wishlist.data;
  } catch (e) {
    print("Error fetching wishlist: $e");
    // Return empty list instead of throwing error
    return [];
  }
}

  Future<void> removeWishlist(CookieRequest request, int itemId) async {
    try {
      await request.post(
        'http://127.0.0.1:8000/wishlist/api/remove/$itemId/',
        {},
      );
      setState(() {
        // Refresh the state after removing
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully removed from wishlist!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to remove from wishlist."),
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
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<WishlistItem>>(
  future: fetchWishlist(request),
  builder: (context, AsyncSnapshot<List<WishlistItem>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (snapshot.hasError) {
      print("Error in snapshot: ${snapshot.error}");
      return Center(
        child: Text("Error: ${snapshot.error}"),
      );
    }
    
    // Handle empty wishlist
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Wishlist is Empty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomeScreen
              },
              child: const Text('Go to Home'),
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
                              'Added: ${DateFormat('dd MMM yyyy').format(item.addedAt)}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
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
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.desc,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
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
                                    foregroundColor: Colors.white,
                                  ),
                                    onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const CreatePaymentScreen(),
                                          ),
                                        );
                                      },
                                  child: const Text('Beli Sekarang'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => removeWishlist(request, item.id),
                                child: const Text('Remove'),
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
    );
  }
}