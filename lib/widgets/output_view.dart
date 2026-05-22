import 'package:flutter/material.dart';

class OutputView extends StatelessWidget {
  final String output;
  final bool isLoading;
  
  const OutputView({
    super.key,
    required this.output,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[850],
            child: const Text(
              'Output:',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: SelectableText(
                        output.isEmpty ? 'Run your code to see output' : output,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
