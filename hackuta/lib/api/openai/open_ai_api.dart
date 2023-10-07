import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateGPT3Response(String inputText) async {
  final apiKey = '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';
  final apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'prompt': inputText,
      'max_tokens': 50, // Adjust as needed
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final generatedText = jsonResponse['choices'][0]['text'];
    return generatedText;
  } else {
    throw Exception('Failed to generate response');
  }
}
