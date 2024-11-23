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
  List<dynamic> categorias = []; // Lista para armazenar as categorias
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProdutos();
    fetchCategorias(); // Chama a função para buscar categorias
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar produtos: $error'),
        ),
      );
    }
  }

  Future<void> fetchCategorias() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3070/flutter/categorias'));

      if (response.statusCode == 200) {
        setState(() {
          categorias = json.decode(response.body);
        });
      } else {
        throw Exception('Erro ao buscar categorias: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar categorias: $error'),
        ),
      );
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

  void adicionarAoCarrinho(Map<String, dynamic> produto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto['nome']} adicionado ao carrinho!'),
      ),
    );
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
              // Campo de pesquisa
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar produtos...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              const SizedBox(height: 20),

              // Exibição das categorias
              const Text(
                'Categorias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              categorias.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 50, // Tamanho da área de categorias
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = categorias[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Chip(
                              label: Text(categoria['tipo']),
                              backgroundColor: const Color(0xFFC54444),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),

              const SizedBox(height: 20),

              // Exibição dos produtos
              const Text(
                'Produtos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: produtosFiltrados.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.isEmpty
                              ? 'Nenhum produto disponível.'
                              : 'Nenhum produto encontrado para "${_searchController.text}".',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
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
                              imageUrl: imageUrl,
                              onAddToCart: () => adicionarAoCarrinho(produto),
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

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String size;
  final String imageUrl;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
    required this.imageUrl,
    required this.onAddToCart,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(description),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC54444), // Cor vermelha
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: onAddToCart,
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Adicionar'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFC54444),
                        ),
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
