import 'dart:convert';
import 'package:http/http.dart' as http;

class AIAPI {
  final String apiKey;
  final String baseUrl;

  AIAPI({required this.apiKey, required this.baseUrl});

  /// Sends a request to the AI API and returns the response as a string.
  Future<String> sendRequest(String prompt) async {
    try {
      // Define the endpoint (modify as per your AI API requirements)
      final url = Uri.parse('$baseUrl/v1/completions');

      // Set headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      // Set body
      final body = jsonEncode({
        'model': 'text-davinci-003', // Replace with your model
        'prompt': prompt,
        'max_tokens': 150,
        'temperature': 0.7,
      });

      // Make POST request
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['choices'][0]['text'];
      } else {
        throw Exception(
            'Failed to fetch response: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in sendRequest: $e');
    }
  }
}
