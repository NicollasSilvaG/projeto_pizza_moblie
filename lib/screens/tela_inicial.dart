import 'package:flutter/material.dart';

class TelaInicialScreen extends StatefulWidget {
  const TelaInicialScreen({super.key});

  @override
  TelaInicialScreenState createState() => TelaInicialScreenState();
}

class TelaInicialScreenState extends State<TelaInicialScreen> {
  int _selectedIndex = 0;

  // Função para alternar entre as páginas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Tela Home (já está nessa tela)
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
            // Campo de Pesquisa
            TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar produtos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: const Color(0xFF2B1C1C)
                    .withOpacity(0.1), // Cor de fundo do campo de pesquisa
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
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Substitua pelo número real de produtos
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: 'Produto $index',
                    description: 'Descrição do produto $index.',
                    price: 'R\$ ${index * 5 + 10},00',
                    imageUrl: 'assets/150x150.jpg', // Caminho da imagem local
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
        color: const Color(0xFF2B1C1C)
            .withOpacity(0.1), // Usando a nova cor para fundo
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 30,
              color: const Color(0xFF2B1C1C)), // Alterando a cor do ícone
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
          // Alterando o layout para um formato retangular
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                // Carregando a imagem local do produto
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12), // Espaçamento entre a imagem e o texto
            Expanded(
              // Usando Expanded para ocupar o restante do espaço
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis, // Caso o nome seja longo
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600]),
                    overflow:
                        TextOverflow.ellipsis, // Caso a descrição seja longa
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
                          // Ação de adicionar ao carrinho
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC54444),
                          foregroundColor: Colors
                              .white, // Define o texto do botão como branco
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
