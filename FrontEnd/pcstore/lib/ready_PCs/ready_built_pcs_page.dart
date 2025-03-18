import 'package:flutter/material.dart';

class ReadyBuiltPCsPage extends StatelessWidget {
  const ReadyBuiltPCsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Gaming', 'icon': Icons.sports_esports, 'color': Colors.red},
      {'name': 'Office', 'icon': Icons.business_center, 'color': Colors.blue},
      {'name': 'Design', 'icon': Icons.brush, 'color': Colors.purple},
      {'name': 'Development', 'icon': Icons.code, 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ready-built PCs'),
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
                      PCListPage(category: category['name'] as String),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: category['color'] as Color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (category['color'] as Color).withOpacity(0.5),
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

class PCListPage extends StatelessWidget {
  final String category;

  const PCListPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a placeholder. In a real app, you'd fetch this data from a backend.
    final pcs = List.generate(
        5,
        (index) => {
              'name': '$category PC ${index + 1}',
              'price': 800 + (index * 200),
              'specs': 'Intel i5, 16GB RAM, 512GB SSD, RTX 3060',
              'image': 'https://placeholder.com/300x200',
            });

    return Scaffold(
      appBar: AppBar(
        title: Text('$category PCs'),
      ),
      body: ListView.builder(
        itemCount: pcs.length,
        itemBuilder: (context, index) {
          final pc = pcs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PCDetailPage(pc: pc),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    child: Image.network(
                      pc['image'] as String,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pc['name'] as String,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            pc['specs'] as String,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${pc['price']}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                        ],
                      ),
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

class PCDetailPage extends StatelessWidget {
  final Map<String, dynamic> pc;

  const PCDetailPage({Key? key, required this.pc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a placeholder. In a real app, you'd have more detailed information.
    final parts = [
      {'name': 'CPU', 'spec': 'Intel Core i5-11600K'},
      {'name': 'GPU', 'spec': 'NVIDIA GeForce RTX 3060'},
      {'name': 'RAM', 'spec': '16GB DDR4 3200MHz'},
      {'name': 'Storage', 'spec': '512GB NVMe SSD'},
      {'name': 'Motherboard', 'spec': 'ASUS Prime B560M-A'},
      {'name': 'Power Supply', 'spec': '650W 80+ Gold'},
      {'name': 'Case', 'spec': 'NZXT H510'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pc['name'] as String),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              pc['image'] as String,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pc['name'] as String,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${pc['price']}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Specifications:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...parts.map((part) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                part['name'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(part['spec'] as String),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add to cart functionality
                    },
                    child: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
