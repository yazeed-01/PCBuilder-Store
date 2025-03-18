import 'package:flutter/material.dart';
import 'package:pcstore/products_pages/product_listing_page.dart';

class ProductCategoriesPage extends StatelessWidget {
  const ProductCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'CPU', 'icon': Icons.memory},
      {'name': 'GPU', 'icon': Icons.videocam},
      {'name': 'Motherboard', 'icon': Icons.developer_board},
      {'name': 'RAM', 'icon': Icons.sd_storage},
      {'name': 'Storage', 'icon': Icons.storage},
      {'name': 'Power Supply', 'icon': Icons.power},
      {'name': 'Case', 'icon': Icons.computer},
      {'name': 'Cooling', 'icon': Icons.ac_unit},
      {'name': 'Accessories', 'icon': Icons.cable},
      {'name': 'Monitor', 'icon': Icons.monitor},
      {'name': 'Software', 'icon': Icons.code},
      {'name': 'Laptop', 'icon': Icons.laptop},
      {'name': 'Network Product', 'icon': Icons.network_check},
      {'name': 'Headphones', 'icon': Icons.headset},
      {'name': 'Cables', 'icon': Icons.cable},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductListingPage(category: category['name'] as String),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[300]!.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category['name'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
