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
  print("generateGPT3Response"+response.statusCode.toString());
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final generatedText = jsonResponse['choices'][0]['message']['content'];
    return generatedText;
  } else {
    throw Exception('Failed to generate response');
  }
}