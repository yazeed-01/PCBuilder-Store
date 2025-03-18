import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pcstore/home_pages/all_sections_page.dart';
import 'package:pcstore/offers_page.dart/offers_page.dart';
import 'package:pcstore/build_pc_pages/build_your_pc_page.dart';
import 'package:pcstore/cart_page/cart_page.dart';
import 'package:pcstore/compare_products_pages/compare_product.dart';
import 'package:pcstore/products_pages/product_categories_page.dart';
import 'package:pcstore/profile_settings_pages/profile_page.dart';
import 'package:pcstore/ready_PCs/ready_built_pcs_page.dart';
import 'package:pcstore/support_pages/suppot_page.dart';
import 'package:pcstore/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showSearch = false;

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
    });
  }

  void _performSearch(String query) {
    // TODO: Implement search functionality
    print('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          if (_showSearch)
            SearchBarWidget(
              onSearch: _performSearch,
              onClose: _toggleSearch,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarousel(),
                  const SizedBox(height: 20),
                  _buildSection(context, 'Best Deals', Colors.red),
                  _buildSection(context, 'Popular Products', Colors.green),
                  _buildSection(context, 'Featured Products', Colors.blue),
                  _buildSection(context, 'New Products', Colors.purple),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Products', Icons.computer,
              () => ProductCategoriesPage()),
          _buildDrawerItem(
              context, 'Profile', Icons.person, () => ProfilePage()),
          _buildDrawerItem(
              context, 'Build Your PC', Icons.build, () => BuildYourPCPage()),
          _buildDrawerItem(context, 'Compare Products', Icons.compare,
              () => CompareProductsPage()),
          _buildDrawerItem(
              context, 'Offers', Icons.local_offer, () => OffersPage()),
          _buildDrawerItem(context, 'Ready-Built PCs', Icons.computer_rounded,
              () => ReadyBuiltPCsPage()),
          _buildDrawerItem(
              context, 'Support', Icons.support_agent, () => SupportPage()),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, String title, IconData icon, Function pageBuilder) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageBuilder()),
        );
      },
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Featured Product $i',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSection(BuildContext context, String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllSectionsPage(initialSection: title),
                    ),
                  );
                },
                child: const Text('See More'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.computer,
                          color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Product ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${(index + 1) * 100}'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
