import 'package:flutter/material.dart';

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  _CarrinhoScreenState createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final List<CartItem> cartItems = [
    CartItem(name: 'Xis Frango com Catupiry', price: 14.90, quantity: 1),
    CartItem(name: 'Xis Coração', price: 16.90, quantity: 1),
  ];

  double get total => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  String formatCurrency(double value) {
    return value.toStringAsFixed(2).replaceAll('.', ',');
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFC54444),
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,  // Título em negrito
          ),
        ),
        actions: [
          // Botão "Limpar Carrinho" com texto e ícone
          TextButton.icon(
            onPressed: clearCart,
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            label: const Text(
              'Limpar Carrinho',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),  // A seta é da mesma cor que o título
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,  // Cor do fundo branca
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Produtos Selecionados',  // Cor alterada para Color(0xFF2B1C1C)
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B1C1C),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  for (var item in cartItems) _buildCartItem(item),
                ],
              ),
            ),

            // Linha divisória entre a lista de itens e a área de total
            const Divider(
              color: Color(0xFF2B1C1C),  // Cor da linha
              thickness: 2,  // Espessura da linha
              height: 20,  // Espaçamento ao redor da linha
            ),
            
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total de Itens: $totalQuantity',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Total: R\$${formatCurrency(total)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC54444),  // Cor do total igual a da AppBar
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.add, color: Color(0xFFC54444)),
              label: const Text(
                'Adicionar mais produtos ao carrinho',
                style: TextStyle(color: Color(0xFFC54444), fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                // Lógica para continuar com o pedido
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B1C1C),  // Cor alterada para o valor especificado
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),  // Texto branco
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
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
            Container(
              color: Colors.orange,
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  // Preço do produto com a mesma cor da AppBar
                  Text(
                    'R\$${formatCurrency(item.price)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC54444),  // Cor alterada para a da AppBar
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF2B1C1C)),  // Cor alterada
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              cartItems.remove(item);
                            }
                          });
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2B1C1C)),  // Cor alterada
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  // Adicionando o mini botão de "Ver mais"
                  TextButton(
                    onPressed: () {
                      // Lógica para ver mais detalhes do produto
                    },
                    child: const Text(
                      "Ver mais...",
                      style: TextStyle(
                        color: Color(0xFF2B1C1C),  // Cor alterada
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // Ícone da lixeira
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFF2B1C1C)),  // Cor alterada
                  onPressed: () {
                    setState(() {
                      cartItems.remove(item);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}
