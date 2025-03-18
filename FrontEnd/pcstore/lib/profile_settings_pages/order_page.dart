import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample order data
    final orders = [
      {'id': '1001', 'date': '2023-05-01', 'total': 999, 'status': 'Delivered'},
      {'id': '1002', 'date': '2023-05-05', 'total': 1299, 'status': 'Shipped'},
      {'id': '1003', 'date': '2023-05-10', 'total': 1599, 'status': 'Processing'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Order #${order['id']}'),
              subtitle: Text('Date: ${order['date']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${order['total']}'),
                  Text(
                    order['status'] as String,
                    style: TextStyle(
                      color: order['status'] == 'Delivered' ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(orderId: order['id'] as String),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample order detail data
    final orderDetail = {
      'id': orderId,
      'date': '2023-05-01',
      'total': 999,
      'status': 'Delivered',
      'address': '123 Main St, City, Country',
      'phoneNumber': '+1 234 567 8900',
      'products': [
        {'name': 'Product A', 'price': 499, 'quantity': 1},
        {'name': 'Product B', 'price': 500, 'quantity': 1},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${orderDetail['id']}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _buildInfoRow('Date', orderDetail['date'] as String),
            _buildInfoRow('Status', orderDetail['status'] as String),
            _buildInfoRow('Total', '\$${orderDetail['total']}'),
            const SizedBox(height: 16),
            Text('Shipping Information', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _buildInfoRow('Address', orderDetail['address'] as String),
            _buildInfoRow('Phone', orderDetail['phoneNumber'] as String),
            const SizedBox(height: 16),
            Text('Products', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...(orderDetail['products'] as List).map((product) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Quantity: ${product['quantity']}'),
                        ],
                      ),
                    ),
                    Text('\$${product['price']}'),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

