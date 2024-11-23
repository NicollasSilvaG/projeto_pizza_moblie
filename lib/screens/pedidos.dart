import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PedidosUsuarioScreen extends StatefulWidget {
  const PedidosUsuarioScreen({super.key});

  @override
  _PedidosUsuarioScreenState createState() => _PedidosUsuarioScreenState();
}

class _PedidosUsuarioScreenState extends State<PedidosUsuarioScreen> {
  int _selectedIndex = 1; // O índice 1 é para "Pedidos"
  String _searchQuery = '';
  final List<Map<String, String>> _pedidos = [
    {
      "dataPedido": "26/10/2024",
      "produto": "Pizza de Calabresa com Queijo",
      "valorTotal": "R\$ 45,00",
      "status": "Entregue",
    },
    {
      "dataPedido": "14/11/2024",
      "produto": "Pizza Portuguesa",
      "valorTotal": "R\$ 50,00",
      "status": "A caminho",
    },
    {
      "dataPedido": "13/04/2023",
      "produto": "Pizza de Frango com Catupiry",
      "valorTotal": "R\$ 48,00",
      "status": "Entregue",
    },
    {
      "dataPedido": "02/10/2023",
      "produto": "Pizza de Calabresa",
      "valorTotal": "R\$ 45,00",
      "status": "Entregue",
    },
  ];

  DateTime _parseDate(String date) {
    return DateFormat("dd/MM/yyyy").parse(date);
  }

  // Função para filtrar os pedidos
  List<Map<String, String>> get _filteredPedidos {
    return _pedidos.where((pedido) {
      return pedido['produto']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

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
        break;
      case 2:
        Navigator.pushNamed(context, '/cupons');
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
            color: const Color(0xFF151414),
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
            const Text(
              'Pedidos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Campo de pesquisa
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar pedidos...',
                hintStyle: TextStyle(color: Colors.grey[600]), // Estilo do texto de dica
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red), // Cor da borda ao focar
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[600], // Cor do ícone
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de pedidos filtrados
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPedidos.length,
                itemBuilder: (context, index) {
                  final pedido = _filteredPedidos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Exibindo a imagem com bordas arredondadas
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12), // Borda arredondada
                            child: Image.asset(
                              'assets/150x150.jpg', // Caminho da nova imagem
                              width: 80, // Novo tamanho
                              height: 80, // Novo tamanho
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Informações do pedido
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pedido em ${pedido['dataPedido']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  pedido['produto']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Valor Total: ${pedido['valorTotal']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Status: ${pedido['status']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/detalhes_pedido',
                                        arguments: pedido, // Passa o pedido como argumento
                                      );
                                    },
                                    child: const Text("Ver mais"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
            icon: Icon(Icons.shopping_bag),
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
