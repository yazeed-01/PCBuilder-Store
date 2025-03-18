import 'package:flutter/material.dart';

class AllSectionsPage extends StatefulWidget {
  final String initialSection;

  const AllSectionsPage({Key? key, required this.initialSection}) : super(key: key);

  @override
  _AllSectionsPageState createState() => _AllSectionsPageState();
}

class _AllSectionsPageState extends State<AllSectionsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _sections = ['Best Deals', 'Popular Products', 'Featured Products', 'New Products'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _sections.length, vsync: this);
    _tabController.animateTo(_sections.indexOf(widget.initialSection));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Sections'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _sections.map((section) => Tab(text: section)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _sections.map((section) => _buildSectionGrid(section)).toList(),
      ),
    );
  }

  Widget _buildSectionGrid(String section) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 10, // Adjust this number based on your actual data
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  child: Center(
                    child: Icon(Icons.computer, size: 50, color: Colors.grey[600]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${(index + 1) * 100}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

