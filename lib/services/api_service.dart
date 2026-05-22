import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Using Piston API (free, open source)
  static const String _apiUrl = 'https://emkc.org/api/v2/piston/execute';
  
  Future<String> executeCode({
    required String code,
    required String language,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'language': language,
          'version': _getVersion(language),
          'files': [
            {
              'content': code,
            }
          ],
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final output = data['run']['output'] ?? '';
        final error = data['run']['stderr'] ?? '';
        return error.isNotEmpty ? 'Error:\n$error' : output;
      } else {
        return 'API Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Connection Error: $e';
    }
  }
  
  String _getVersion(String language) {
    switch (language) {
      case 'python':
        return '3.10.0';
      case 'javascript':
        return '18.15.0';
      case 'java':
        return '15.0.2';
      case 'cpp':
        return '10.2.0';
      default:
        return '*';
    }
  }
}
