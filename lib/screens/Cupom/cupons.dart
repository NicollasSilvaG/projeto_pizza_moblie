import 'package:flutter/material.dart';

class CuponsScreen extends StatefulWidget {
  const CuponsScreen({super.key});

  @override
  _CuponsScreenState createState() => _CuponsScreenState();
}

class _CuponsScreenState extends State<CuponsScreen> {
  int _selectedIndex = 2; // O índice 2 é para "Cupons"

  // Lista de cupons ativos (simulando dados)
  final List<Map<String, String>> cuponsAtivos = [
    {'codigo': 'PROMO10', 'desconto': '10%', 'status': 'Ativo'},
    {'codigo': 'DESCONTO20', 'desconto': '20%', 'status': 'Ativo'},
  ];

  // Função para alternar entre as páginas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/pedidos');
        break;
      case 2:
        // Já estamos na tela Cupons, então não faz nada
        break;
      case 3:
        Navigator.pushNamed(context, '/conta');
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
            color: const Color(0xFF2B1C1C), // Define a cor do ícone do carrinho como branco
            onPressed: () {
              Navigator.pushNamed(context, '/carrinho');
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título "Cupons"
            const Text(
              'Cupons',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20), // Espaço entre o título e o conteúdo

            // Exibindo a lista de cupons ativos
            const Text(
              'Cupons Ativos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Lista de cupons ativos
            Expanded(
              child: ListView.builder(
                itemCount: cuponsAtivos.length,
                itemBuilder: (context, index) {
                  final cupom = cuponsAtivos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.local_offer),
                      title: Text(cupom['codigo']!),
                      subtitle: Text('Desconto: ${cupom['desconto']}'),
                      trailing: Text(cupom['status']!),
                    ),
                  );
                },
              ),
            ),
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
            icon: Icon(Icons.list_alt_sharp),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Cupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Conta',
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
