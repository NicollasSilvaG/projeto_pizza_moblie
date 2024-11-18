import 'package:flutter/material.dart';
import 'dart:convert'; // Para converter JSON
import 'package:http/http.dart' as http;

class TelaInicialScreen extends StatefulWidget {
  const TelaInicialScreen({super.key});

  @override
  TelaInicialScreenState createState() => TelaInicialScreenState();
}

class TelaInicialScreenState extends State<TelaInicialScreen> {
  int _selectedIndex = 0;
  List<dynamic> produtos = []; // Lista para armazenar os produtos

  @override
  void initState() {
    super.initState();
    fetchProdutos(); // Buscar produtos na inicialização
  }

  Future<void> fetchProdutos() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3070/flutter/produtos'), // Endpoint da API
      );

      if (response.statusCode == 200) {
        setState(() {
          produtos = json.decode(response.body); // Converte JSON para lista
        });
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao buscar produtos: $error');
    }
  }

  // Função para alternar entre as páginas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break; // Permanece na tela atual
      case 1:
        Navigator.pushNamed(context, '/pedidos');
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
            // Campo de Pesquisa
            TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar produtos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: const Color(0xFF2B1C1C).withOpacity(0.1),
              ),
            ),
            const SizedBox(height: 20),

            // Seção de Categorias em quadrados com ícones
            const Text(
              'Categorias',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategorySquare(
                    icon: Icons.local_pizza,
                    label: 'Pizza',
                  ),
                  CategorySquare(
                    icon: Icons.local_drink,
                    label: 'Bebidas',
                  ),
                  CategorySquare(
                    icon: Icons.cake,
                    label: 'Sobremesas',
                  ),
                  CategorySquare(
                    icon: Icons.fastfood,
                    label: 'Sanduíches',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Seção de Produtos
            const Text(
              'Produtos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Exibição dos produtos dinamicamente
            Expanded(
              child: produtos.isEmpty
                  ? const Center(child: CircularProgressIndicator()) // Indicador de carregamento
                  : ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return ProductCard(
                          name: produto['nome'],
                          description: produto['descricao'],
                          price: 'R\$ ${produto['preco'].toString()}',
                          imageUrl: 'assets/150x150.jpg', // Exemplo de imagem local
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
            icon: Icon(Icons.card_giftcard),
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

// Widget para exibir categorias em quadrados com ícones
class CategorySquare extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategorySquare({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2B1C1C).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFF2B1C1C)),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Widget para exibir um produto no formato retangular
class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC54444),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para adicionar ao carrinho
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC54444),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Adicionar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
