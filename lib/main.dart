import 'package:flutter/material.dart';
import 'factory/project_vault.dart';
import 'factory/compiler_engine.dart';

void main() => runApp(const MetaAppFactory());

class MetaAppFactory extends StatelessWidget {
  const MetaAppFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // "Fabrika" havası için karanlık tema
      home: const FactoryScreen(),
    );
  }
}

class FactoryScreen extends StatefulWidget {
  const FactoryScreen({super.key});

  @override
  State<FactoryScreen> createState() => _FactoryScreenState();
}

class _FactoryScreenState extends State<FactoryScreen> {
  final TextEditingController _controller = TextEditingController();
  final CompilerEngine _compiler = CompilerEngine();
  bool _isLoading = false;

  Future<void> _buildApp() async {
    if (_controller.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      // 1. Yapay zeka ile kod üret
      String code = await _compiler.generateCode(_controller.text);

      // 2. Dosyayı kaydet
      await ProjectVault.saveFile('generated_app.dart', code);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Başarılı: Kod fabrikadan çıktı!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata oluştu: $e")),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fabrika: On-Device Builder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Örn: Bir sayaç uygulaması yap...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _buildApp,
                    child: const Text("İnşa Et"),
                  ),
          ],
        ),
      ),
    );
  }
}
