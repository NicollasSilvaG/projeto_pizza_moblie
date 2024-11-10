import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:3070'; // URL do backend

  Future<void> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/flutter/login'),
      body: jsonEncode({'email': email, 'senha': senha}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Trate o login com sucesso
    } else {
      // Trate erro de login
    }
  }

  Future<void> cadastrarUsuario({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
    String? rua,
    String? cidade,
    String? cep,
    String? bairro,
    String? complemento,
    String? uf,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/flutter/cadastro'), 
      body: json.encode({
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'senha': senha,
        'rua': rua,
        'cidade': cidade,
        'cep': cep,
        'bairro': bairro,
        'complemento': complemento,
        'uf': uf,
      }),

      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao cadastrar usuário');
    }
  }
}