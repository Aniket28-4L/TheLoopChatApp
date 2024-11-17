import 'ai_api.dart';

class AIChat {
  final AIAPI apiClient;

  AIChat({required this.apiClient});

  /// Sends a user message to the AI and gets the AI's response.
  Future<String> chat(String userMessage) async {
    try {
      // Compose the chat prompt with context if necessary
      String prompt = _buildChatPrompt(userMessage);

      // Use the API client to get the AI's response
      String aiResponse = await apiClient.sendRequest(prompt);

      return _formatResponse(aiResponse);
    } catch (e) {
      throw Exception('Error in chat: $e');
    }
  }

  /// Optionally build a chat prompt to include previous messages or context
  String _buildChatPrompt(String userMessage) {
    return '''
You are a helpful AI assistant. Respond to the following message from the user:
User: "$userMessage"
AI:
    ''';
  }

  /// Format the AI's response for a better chat experience.
  String _formatResponse(String response) {
    return response.trim(); // Clean up the response (if needed)
  }
}
