import 'package:flutter/material.dart';
import 'screens/Login_Cadastro/cadastro_cliente.dart';
import 'screens/Login_Cadastro/login_usuario.dart';
import 'screens/tela_inicial.dart';
import 'package:dom_pizzaria_moblie/screens/Produto/detalhesProduto.dart';
import 'package:dom_pizzaria_moblie/screens/Pedidos/carrinho.dart';
import 'package:dom_pizzaria_moblie/screens/Pedidos/pedidos.dart';
import 'package:dom_pizzaria_moblie/screens/Pedidos/detalhes_pedido.dart';
import 'package:dom_pizzaria_moblie/screens/Pedidos/finalizar_pedido.dart';
import 'package:dom_pizzaria_moblie/screens/Cupom/cupons.dart';
import 'package:dom_pizzaria_moblie/screens/MinhaConta/minha_conta.dart';
import 'package:dom_pizzaria_moblie/screens/MinhaConta/ContaSegurancaScreen.dart';
import 'package:dom_pizzaria_moblie/screens/MinhaConta/AtualizarPerfil.dart';
import 'package:dom_pizzaria_moblie/screens/MinhaConta/AlterarEndereco.dart';
import 'package:dom_pizzaria_moblie/screens/MinhaConta/AlterarSenha.dart';

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
        '/detalhesProduto': (context) => const DetalhesProdutoScreen(),
        '/carrinho': (context) => const CarrinhoScreen(),
        '/pedidos': (context) => const PedidosUsuarioScreen(),
        '/finalizar_pedido': (context) => const FinalizarPedidoScreen(),
        '/detalhes_pedido': (context) {
          final Map<String, String> pedido = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return VisualizarPedidoScreen(pedido: pedido);
        },
        '/cupons': (context) => const CuponsScreen(),
        '/conta': (context) => const MinhaContaScreen(),
        '/conta_seguranca': (context) => const ContaSegurancaScreen(),
        '/atualizar_perfil': (context) => const AtualizarPerfilScreen(),
        '/alterar_endereco': (context) => const AlterarEnderecoScreen(),
        '/alterar_senha': (context) => const AlterarSenhaScreen(),

      },
    );
  }
}
