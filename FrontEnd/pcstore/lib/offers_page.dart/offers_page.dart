import 'package:flutter/material.dart';
import 'dart:async';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  List<Map<String, dynamic>> offers = [
    {
      'id': '1',
      'name': 'Gaming PC Bundle',
      'originalPrice': 1500,
      'discountedPrice': 1299,
      'endTime': DateTime.now().add(const Duration(days: 3)),
      'image': 'https://placeholder.com/300x200',
      'description':
          'High-performance gaming PC with RTX 3070, Ryzen 7 5800X, 32GB RAM, and 1TB NVMe SSD.',
    },
    {
      'id': '2',
      'name': 'High-Performance SSD',
      'originalPrice': 150,
      'discountedPrice': 99,
      'endTime': DateTime.now().add(const Duration(hours: 12)),
      'image': 'https://placeholder.com/300x200',
      'description':
          '1TB NVMe SSD with read speeds up to 7000MB/s and write speeds up to 5000MB/s.',
    },
    {
      'id': '3',
      'name': 'RGB Mechanical Keyboard',
      'originalPrice': 120,
      'discountedPrice': 89,
      'endTime': DateTime.now().add(const Duration(minutes: 30)),
      'image': 'https://placeholder.com/300x200',
      'description':
          'Full-size mechanical keyboard with RGB backlighting and Cherry MX Blue switches.',
    },
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Offers'),
      ),
      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          final timeLeft = offer['endTime'].difference(DateTime.now());

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: offer),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    offer['image'] as String,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer['name'] as String,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '\$${offer['discountedPrice']}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${offer['originalPrice']}',
                              style: const TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Time left: ${_formatDuration(timeLeft)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
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

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return 'Offer expired';
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    parts.add('${seconds}s');

    return parts.join(' ');
  }
}

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late DateTime endTime;
  late Duration timeLeft;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    endTime = widget.product['endTime'] as DateTime;
    timeLeft = endTime.difference(DateTime.now());
    formattedTime = _formatDuration(timeLeft);

    // Set up a timer to update the remaining time
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          timeLeft = endTime.difference(DateTime.now());
          formattedTime = _formatDuration(timeLeft);
        });
        _startTimer(); // Recursively call to update the timer every second
      }
    });
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return 'Offer expired';
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    parts.add('${seconds}s');

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name'] as String),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product['image'] as String,
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
                    widget.product['name'] as String,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${widget.product['discountedPrice']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${widget.product['originalPrice']}',
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time left: $formattedTime',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.product['description'] as String),
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
