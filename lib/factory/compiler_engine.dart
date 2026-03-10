class CompilerEngine {
  String generateCode(String userRequest) {
    // Burada yapay zekadan gelecek olan karmaşık mantığı şimdilik 
    // statik bir şablonla başlatıyoruz.
    return """
import 'package:flutter/material.dart';

void main() => runApp(const GeneratedApp());

class GeneratedApp extends StatelessWidget {
  const GeneratedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Üretilen Uygulama")),
        body: Center(child: Text("$userRequest")),
      ),
    );
  }
}
    """;
  }
}
