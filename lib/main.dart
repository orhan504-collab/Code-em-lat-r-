import 'package:flutter/material.dart';
import 'factory/project_vault.dart';
import 'factory/compiler_engine.dart';

void main() => runApp(const MetaAppFactory());

class MetaAppFactory extends StatelessWidget {
  const MetaAppFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FactoryScreen(),
    );
  }
}

class FactoryScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final CompilerEngine _compiler = CompilerEngine();

  FactoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kendi Kendini İnşa Eden Fabrika")),
      body: Column(
        children: [
          TextField(controller: _controller, decoration: const InputDecoration(hintText: "Ne inşa etmek istersin?")),
          ElevatedButton(
            onPressed: () async {
              String code = _compiler.generateCode(_controller.text);
              await ProjectVault.saveFile('lib/generated_app.dart', code);
              // Burada derleme tetiklenecek
            },
            child: const Text("İnşa Et"),
          ),
        ],
      ),
    );
  }
}
