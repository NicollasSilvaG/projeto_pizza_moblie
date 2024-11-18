import 'package:dom_pizzaria_moblie/screens/detalhes_pedido.dart';
import 'package:flutter/material.dart';
import 'package:dom_pizzaria_moblie/screens/carrinho.dart';
import 'package:dom_pizzaria_moblie/screens/cupons.dart';
import 'package:dom_pizzaria_moblie/screens/finalizar_pedido.dart';
import 'package:dom_pizzaria_moblie/screens/minha_conta.dart';
import 'package:dom_pizzaria_moblie/screens/pedidos.dart';

import 'screens/cadastro_cliente.dart';
import 'screens/login_usuario.dart';
import 'screens/tela_inicial.dart';

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
        '/home': (context) => const TelaInicialScreen(),
        '/pedidos': (context) => const PedidosUsuarioScreen(),
        '/cupons': (context) => const CuponsScreen(),
        '/conta': (context) => const MinhaContaScreen(),
        '/carrinho': (context) => const CarrinhoScreen(),
        '/finalizar_pedido': (context) => const FinalizarPedidoScreen(),
        
        // Nova rota para a tela de Visualizar Pedido
        '/detalhes_pedido': (context) {
          final Map<String, String> pedido = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return VisualizarPedidoScreen(pedido: pedido);
        },
      },
    );
  }
}
