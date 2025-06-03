import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl =
      'https://peaksmartth-production.up.railway.app'; // Replace with your actual URL

  // Method to fetch data
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Method to post data (e.g., for login, registration)
  Future<http.Response> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    return response;
  }
}
