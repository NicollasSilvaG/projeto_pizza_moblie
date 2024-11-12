import 'package:flutter/material.dart';

class PedidosUsuarioScreen extends StatefulWidget {
  const PedidosUsuarioScreen({super.key});

  @override
  _PedidosUsuarioScreenState createState() => _PedidosUsuarioScreenState();
}

class _PedidosUsuarioScreenState extends State<PedidosUsuarioScreen> {
  int _selectedIndex = 1; // O índice 1 é para "Pedidos"

  // Função para alternar entre as páginas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home'); // Corrigido para a rota /home
        break;
      case 1:
        // Já estamos na tela Pedidos, então não faz nada
        break;
      case 2:
        Navigator.pushNamed(context, '/cupons');
        break;
      case 3:
        Navigator.pushNamed(context, '/perfil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remover o botão de retorno
        toolbarHeight: 120, // Define uma altura maior para a AppBar
        backgroundColor: const Color(0xFFC54444),
        centerTitle: true, // Centraliza o título
        title: Image.asset(
          'assets/logo.png', // Caminho da logo
          height: 100, // Aumenta a altura da imagem
          fit: BoxFit.contain, // Garante que a imagem não será cortada
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: const Color(0xFF151414), // Define a cor do ícone do carrinho como branco
            onPressed: () {
              Navigator.pushNamed(context, '/carrinho');
            },
          ),
        ],
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título "Pedidos"
            Text(
              'Pedidos',
              style: TextStyle(
                fontSize: 24, // Aumenta o tamanho da fonte
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cor do título
              ),
            ),
            SizedBox(height: 20), // Espaço entre o título e o conteúdo

            // Exibindo o texto com conteúdo de pedidos
            Text(
              'Aqui vai o conteúdo de pedidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Adicione o conteúdo de pedidos aqui
          ],
        ),
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
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFC54444),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
