import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'Product A', 'price': 999, 'quantity': 1},
    {'name': 'Product B', 'price': 1299, 'quantity': 1},
  ];

  String discountCode = '';

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']} x ${item['quantity']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (item['quantity'] > 1) {
                              item['quantity']--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                      ),
                      Text('${item['quantity']}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            item['quantity']++;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Discount Code',
                  ),
                  onChanged: (value) {
                    setState(() {
                      discountCode = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text('Total: \$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  },
                  child: const Text('GO TO CHECKOUT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedAddress = '';
  String selectedPaymentMethod = '';

  final List<String> savedAddresses = [
    '123 Main St, City, Country',
    '456 Elm St, Town, Country',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...savedAddresses.map((address) => RadioListTile<String>(
              title: Text(address),
              value: address,
              groupValue: selectedAddress,
              onChanged: (value) {
                setState(() {
                  selectedAddress = value!;
                });
              },
            )),
            OutlinedButton(
              onPressed: () {
                // TODO: Implement add new address functionality
              },
              child: const Text('Add New Address'),
            ),
            const SizedBox(height: 24),
            Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _buildPaymentMethodTile('Cash on Delivery', 'assets/cash_icon.png'),
            _buildPaymentMethodTile('Visa', 'assets/visa_icon.png'),
            _buildPaymentMethodTile('Mastercard', 'assets/mastercard_icon.png'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
                  );
                },
                child: const Text('PLACE ORDER'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String method, String iconPath) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          const SizedBox(width: 8),
          Text(method),
        ],
      ),
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
    );
  }
}

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 16),
            Text('Order Placed Successfully!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('BACK TO HOME'),
            ),
          ],
        ),
      ),
    );
  }
}

