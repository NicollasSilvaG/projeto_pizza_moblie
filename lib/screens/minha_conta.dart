import 'package:flutter/material.dart';

class MinhaContaScreen extends StatelessWidget {
  final String nomeUsuario = "Usuário";

  const MinhaContaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        backgroundColor: const Color(0xFFC54444),
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 100,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: const Color(0xFF2B1C1C),
            onPressed: () {
              Navigator.pushNamed(context, '/carrinho');
            },
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Cor de fundo do container
              borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
            ),
            child: Row(
              children: [
                const Icon(Icons.person, size: 40), // Ícone de usuário
                const SizedBox(width: 12), // Espaço entre o ícone e o texto
                Text(
                  nomeUsuario,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Espaço entre o container e os itens seguintes
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Conta & Segurança"),
            onTap: () {
              // Navegar para a tela de Conta & Segurança
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text("Fale conosco"),
            onTap: () {
              // Navegar para a tela de Fale conosco
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            onTap: () {
              // Navegar para a tela de Configurações
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair"),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login', // Tela de login
                (route) => false,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Cupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Conta',
          ),
        ],
        currentIndex: 3, // Define o índice da aba "Perfil"
        selectedItemColor: const Color(0xFFC54444),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/pedidos');
              break;
            case 2:
              Navigator.pushNamed(context, '/cupons');
              break;
            case 3:
              // Já está na tela de Conta
              break;
          }
        },
      ),
    );
  }
}
