import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://apiauth-hold.onrender.com/api/';

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      print('Register response: ${response.body}'); // Debug log

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return {'error': 'Registration failed: ${response.body}'};
      }
    } catch (e) {
      print('Register error: $e'); // Debug log
      return {'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> login(Map<String, String> credentials) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials),
      );

      print('Login response: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        final decodedToken = parseJwt(token);
        final userId = decodedToken['userId'];

        // Fetch user details using the extracted user ID
        final userDetails = await getUserDetails(userId, token);

        return {
          ...responseData,
          ...userDetails,
          '_id': userId,
        };
      } else {
        return {'error': 'Login failed: ${response.body}'};
      }
    } catch (e) {
      print('Login error: $e'); // Debug log
      return {'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> getCurrentUser(String token) async {
    try {
      final url = Uri.parse('$baseUrl/current-user');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Get current user response: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Failed to fetch user data: ${response.body}'};
      }
    } catch (e) {
      print('Get current user error: $e'); // Debug log
      return {'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> getUserDetails(
      String userId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/users/$userId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Get user details response: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Failed to fetch user details: ${response.body}'};
      }
    } catch (e) {
      print('Get user details error: $e'); // Debug log
      return {'error': 'Error: $e'};
    }
  }

  Future<http.Response> updateUser(
      String id, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update user');
    }
  }
}
