import 'package:dart_eval/dart_eval.dart';

class RuntimeLoader {
  void runCode(String code) {
    final eval = Evaluator();
    // Kodun buraya enjekte edilip canlı widget olarak dönüştürülmesi
    eval.execute(code);
  }
}
