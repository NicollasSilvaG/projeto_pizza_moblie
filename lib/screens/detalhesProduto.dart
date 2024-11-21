import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetalhesProdutoScreen extends StatelessWidget {
  const DetalhesProdutoScreen({super.key});

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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
            Text(
              produto['price'],
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC54444)),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Lógica para adicionar ao carrinho
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC54444),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
