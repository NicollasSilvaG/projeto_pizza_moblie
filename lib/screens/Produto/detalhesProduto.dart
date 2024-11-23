import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetalhesProdutoScreen extends StatefulWidget {
  const DetalhesProdutoScreen({super.key});

  @override
  _DetalhesProdutoScreenState createState() => _DetalhesProdutoScreenState();
}

class _DetalhesProdutoScreenState extends State<DetalhesProdutoScreen> {
  int quantidade = 1;

  void _incrementarQuantidade() {
    setState(() {
      quantidade++;
    });
  }

  void _decrementarQuantidade() {
    if (quantidade > 1) {
      setState(() {
        quantidade--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> produto =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(produto['name']),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: produto['imageUrl'],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              produto['name'],
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              produto['description'],
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Text(
              'Tamanho: ${produto['size']}',
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            
            // Preço do produto
            Row(
              children: [
                Text(
                  produto['price'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC54444)),
                ),
                const SizedBox(width: 20),

                // Botão de diminuir
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC54444),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: _decrementarQuantidade,
                  ),
                ),
                const SizedBox(width: 10),

                // Texto da quantidade
                Text(
                  '$quantidade',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),

                // Botão de aumentar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC54444),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _incrementarQuantidade,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Botão de adicionar ao carrinho com ícone
            ElevatedButton.icon(
              onPressed: () {
                // Lógica para adicionar ao carrinho
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${produto['name']} adicionado ao carrinho!')),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Adicionar ao Carrinho'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC54444),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
