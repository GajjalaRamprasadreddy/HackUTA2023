import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateGPT3Response(String inputText) async {
  print(inputText);
  final apiKey = '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';
  final apiUrl = 'https://api.openai.com/v1/chat/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'messages': [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": inputText},
      ],
      'max_tokens': 50,
      "model": "gpt-3.5-turbo",
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final generatedText = jsonResponse['choices'][0]['message']['content'];
    return generatedText;
  } else {
    throw Exception('Failed to generate response');
  }
}
