import 'package:flutter/material.dart';
import 'screens/cadastro_cliente.dart';
import 'screens/login_usuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOM Pizzas',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginUsuarioScreen(),
        '/cadastro': (context) => const CadastroClienteScreen(),
      },
    );
  }
}
