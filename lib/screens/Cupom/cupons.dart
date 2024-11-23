import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CuponsScreen extends StatefulWidget {
  const CuponsScreen({super.key});

  @override
  _CuponsScreenState createState() => _CuponsScreenState();
}

class _CuponsScreenState extends State<CuponsScreen> {
  int _selectedIndex = 2; // O índice 2 é para "Cupons"
  final TextEditingController _cupomController = TextEditingController();

  // Função para buscar cupons do backend
  Future<List<Map<String, dynamic>>> _buscarCuponsAtivos() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3070/flutter/cupons'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Filtra apenas os cupons ativos
      return data.where((cupom) => cupom['status'] == 'Ativo').cast<Map<String, dynamic>>().toList();
    } else {
      throw Exception('Erro ao buscar cupons');
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cupons',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Campo de inserção de cupom
            TextField(
              controller: _cupomController,
              decoration: InputDecoration(
                labelText: 'Digite o código do cupom',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Função de adicionar cupom
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Exibindo a lista de cupons ativos
            const Text(
              'Cupons Ativos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Lista de cupons ativos com FutureBuilder
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _buscarCuponsAtivos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Nenhum cupom ativo disponível'),
                    );
                  }

                  final cuponsAtivos = snapshot.data!;
                  return ListView.builder(
                    itemCount: cuponsAtivos.length,
                    itemBuilder: (context, index) {
                      final cupom = cuponsAtivos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.local_offer),
                          title: Text(cupom['codigo']),
                          subtitle: Text('Desconto: ${cupom['porcentagem_desconto']}%'),
                          trailing: Text(cupom['status']),
                        ),
                      );
                    },
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
