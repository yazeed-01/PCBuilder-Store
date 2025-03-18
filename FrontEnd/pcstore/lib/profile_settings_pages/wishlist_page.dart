import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample wishlist data
    final wishlistItems = [
      {'name': 'Product A', 'price': 999, 'image': 'https://placeholder.com/150'},
      {'name': 'Product B', 'price': 1299, 'image': 'https://placeholder.com/150'},
      {'name': 'Product C', 'price': 1599, 'image': 'https://placeholder.com/150'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                item['image'] as String,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item['name'] as String),
              subtitle: Text('\$${item['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // TODO: Implement add to cart functionality
                },
                child: const Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}

