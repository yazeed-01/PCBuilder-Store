import 'package:flutter/material.dart';
import 'package:pcstore/products_pages/product_detail_page.dart';
import 'package:pcstore/widgets/search_bar.dart';

class ProductListingPage extends StatefulWidget {
  final String category;

  const ProductListingPage({Key? key, required this.category})
      : super(key: key);

  @override
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  bool _showSearch = false;
  String _searchQuery = '';
  String _sortBy = 'name';
  bool _sortAscending = true;

  // This is a placeholder list. In a real app, you'd fetch this data from an API or database.
  late List<Map<String, dynamic>> _products;

  @override
  void initState() {
    super.initState();
    _products = List.generate(
      20,
      (index) => {
        'name': '${widget.category} ${index + 1}',
        'price': (index + 1) * 100,
        'rating': (index % 5) + 1,
      },
    );
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
    });
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _sortProducts() {
    setState(() {
      _products.sort((a, b) {
        // Sorting by name (A-Z or Z-A)
        if (_sortBy == 'name') {
          return _sortAscending
              ? a['name'].compareTo(b['name']) // A to Z
              : b['name'].compareTo(a['name']); // Z to A
        }
        // Sorting by price (Low to High or High to Low)
        else if (_sortBy == 'price') {
          return _sortAscending
              ? a['price'].compareTo(b['price']) // Low to High
              : b['price'].compareTo(a['price']); // High to Low
        }
        // Sorting by rating (Low to High or High to Low)
        else if (_sortBy == 'rating') {
          return _sortAscending
              ? a['rating'].compareTo(b['rating']) // Low to High
              : b['rating'].compareTo(a['rating']); // High to Low
        }
        return 0; 
      });
    });
  }

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      return product['name'].toLowerCase().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt),
            onSelected: (String result) {
              setState(() {
                if (result == _sortBy) {
                  _sortAscending = !_sortAscending;
                } else {
                  _sortBy = result;
                  _sortAscending = true; 
                }
              });
              _sortProducts();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'name',
                child: Text('Sort by Name (A-Z)'),
              ),
              const PopupMenuItem<String>(
                value: 'price',
                child: Text('Sort by Price (Low to High)'),
              ),
              const PopupMenuItem<String>(
                value: 'nameDesc',
                child: Text('Sort by Name (Z-A)'),
              ),
              const PopupMenuItem<String>(
                value: 'priceDesc',
                child: Text('Sort by Price (High to Low)'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSearch)
            SearchBarWidget(
              onSearch: _performSearch,
              onClose: _toggleSearch,
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          Icon(Icons.computer_rounded, color: Colors.blue[700]),
                    ),
                    title: Text(product['name'] as String),
                    subtitle: Text('\$${product['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
