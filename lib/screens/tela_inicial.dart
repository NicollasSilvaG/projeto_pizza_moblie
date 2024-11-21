import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class TelaInicialScreen extends StatefulWidget {
  const TelaInicialScreen({super.key});

  @override
  TelaInicialScreenState createState() => TelaInicialScreenState();
}

class TelaInicialScreenState extends State<TelaInicialScreen> {
  int _selectedIndex = 0;
  List<dynamic> produtos = [];
  List<dynamic> produtosFiltrados = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProdutos();
    _searchController.addListener(() {
      filtrarProdutos(_searchController.text);
    });
  }

  Future<void> fetchProdutos() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3070/flutter/produtos'),
      );

      if (response.statusCode == 200) {
        setState(() {
          produtos = json.decode(response.body);
          produtosFiltrados = produtos;
        });
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao buscar produtos: $error');
    }
  }

  void filtrarProdutos(String query) {
    if (query.isEmpty) {
      setState(() {
        produtosFiltrados = produtos;
      });
    } else {
      setState(() {
        produtosFiltrados = produtos.where((produto) {
          final nome = produto['nome'].toLowerCase();
          final textoBusca = query.toLowerCase();
          return nome.contains(textoBusca);
        }).toList();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
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
      body: RefreshIndicator(
        onRefresh: fetchProdutos,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
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
              const Text(
                'Produtos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: produtosFiltrados.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: produtosFiltrados.length,
                        itemBuilder: (context, index) {
                          final produto = produtosFiltrados[index];
                          final imageUrl = 'http://10.0.2.2:3070/${produto['imagem']}';
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detalhesProduto',
                                arguments: {
                                  'name': produto['nome'],
                                  'description': produto['descricao'],
                                  'price': 'R\$ ${produto['preco'].toString().replaceAll('.', ',')}',
                                  'size': produto['tamanho'],
                                  'imageUrl': imageUrl,
                                },
                              );
                            },
                            child: ProductCard(
                              name: produto['nome'],
                              description: produto['descricao'],
                              price: 'R\$ ${produto['preco'].toString().replaceAll('.', ',')}',
                              size: produto['tamanho'],
                              imageUrl: imageUrl, // Correção aqui
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
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

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String size;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  const SizedBox(height: 5),
                  Text(
                    'Tamanho: $size',
                    style: const TextStyle(fontSize: 14),
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
