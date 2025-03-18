import 'package:flutter/material.dart';

class CompareProductsPage extends StatelessWidget {
  const CompareProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for comparison
    final products = [
      {
        'name': 'Product A',
        'price': 999,
        'cpu': 'Intel i5',
        'ram': '8GB',
        'storage': '256GB SSD',
        'gpu': 'NVIDIA GTX 1650',
      },
      {
        'name': 'Product B',
        'price': 1299,
        'cpu': 'Intel i7',
        'ram': '16GB',
        'storage': '512GB SSD',
        'gpu': 'NVIDIA RTX 3060',
      },
      {
        'name': 'Product C',
        'price': 1599,
        'cpu': 'AMD Ryzen 7',
        'ram': '32GB',
        'storage': '1TB SSD',
        'gpu': 'NVIDIA RTX 3070',
      },
    ];

    final specs = ['price', 'cpu', 'ram', 'storage', 'gpu'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Products'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('Specification')),
            ...products.map((product) => DataColumn(label: Text(product['name'] as String))),
          ],
          rows: [
            ...specs.map((spec) => DataRow(
              cells: [
                DataCell(Text(spec.toUpperCase())),
                ...products.map((product) => DataCell(Text(product[spec].toString()))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

