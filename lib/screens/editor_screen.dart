import 'package:flutter/material.dart';
import '../widgets/code_editor.dart';
import '../widgets/output_view.dart';
import '../services/api_service.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _codeController = TextEditingController();
  final ApiService _apiService = ApiService();
  String _output = '';
  bool _isLoading = false;
  String _selectedLanguage = 'python';

  final List<String> _languages = ['python', 'javascript', 'java', 'cpp'];

  Future<void> _runCode() async {
    setState(() {
      _isLoading = true;
      _output = 'Running...';
    });

    try {
      final result = await _apiService.executeCode(
        code: _codeController.text,
        language: _selectedLanguage,
      );
      setState(() {
        _output = result;
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Code Editor'),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            dropdownColor: Colors.grey[900],
            items: _languages.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _runCode,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Run'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: CodeEditor(controller: _codeController),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            flex: 1,
            child: OutputView(output: _output, isLoading: _isLoading),
          ),
        ],
      ),
    );
  }
}
