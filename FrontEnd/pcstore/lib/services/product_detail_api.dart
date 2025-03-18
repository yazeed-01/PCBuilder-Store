import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:3000/api/';

  // getProductDetails function
  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      final url = Uri.parse('$baseUrl/products/$id');
      final response = await http.get(url);

      print('Get product details response: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Failed to fetch product details: ${response.body}'};
      }
    } catch (e) {
      print('Get product details error: $e'); // Debug log
      return {'error': 'Error: $e'};
    }
  }
}
