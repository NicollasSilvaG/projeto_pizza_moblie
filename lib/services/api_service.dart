import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:3000'; // Ajuste para o URL do backend

  Future<void> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode({'email': email, 'senha': senha}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Trate o login com sucesso
    } else {
      // Trate erro de login
    }
  }

  // Adicione outros métodos conforme necessário
}
