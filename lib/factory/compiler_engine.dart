import 'package:google_generative_ai/google_generative_ai.dart';

class CompilerEngine {
  // Buraya API anahtarın gelecek
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'API_KEY');

  Future<String> generateCode(String userRequest) async {
    final prompt = """
    Sen bir Flutter uzmanısın. Kullanıcının isteği üzerine tek bir dosyada çalışan 
    tam bir Flutter uygulaması kodu üret. Kod sadece 'import' ve 'main()' fonksiyonu dahil 
    tek bir dart dosyası olmalı. Kod şu formata uygun olsun:
    
    import 'package:flutter/material.dart';
    void main() => runApp(const MyGeneratedApp());
    class MyGeneratedApp extends StatelessWidget {
      const MyGeneratedApp({super.key});
      @override
      Widget build(BuildContext context) { return ... }
    }
    
    Kullanıcı isteği: $userRequest
    """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "";
  }
}
