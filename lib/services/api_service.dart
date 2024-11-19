import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3070';
  final storage = const FlutterSecureStorage();

  Future<void> cadastrarUsuario({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
    required String rua,
    required String cidade,
    required String cep,
    required String bairro,
    required String complemento,
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Cadastro realizado com sucesso!');
    } else {
      throw Exception('Erro ao cadastrar usuário');
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/flutter/loginuser'),
        body: jsonEncode({'email': email, 'senha': senha}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Armazena o token no armazenamento seguro
        if (data['token'] != null) {
          await storage.write(key: 'token', value: data['token']);
          print("Token armazenado com sucesso!");
        }

        // Trate o login com sucesso, como navegar para uma próxima tela
      } else {
        print("Erro de login: ${response.statusCode}");
      }
    } catch (error) {
      print("Erro na conexão: $error");
    }
  }

  Future<void> fetchProtectedData() async {
    try {
      // Recupera o token armazenado
      String? token = await storage.read(key: 'token');

      if (token != null) {
        final response = await http.get(
          Uri.parse('$baseUrl/flutter/protected-endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          print("Dados protegidos: ${response.body}");
        } else {
          print("Erro ao buscar dados protegidos: ${response.statusCode}");
        }
      } else {
        print("Token não encontrado!");
      }
    } catch (error) {
      print("Erro na conexão: $error");
    }
  }
}
