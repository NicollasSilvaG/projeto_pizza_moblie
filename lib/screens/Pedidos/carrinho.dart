import 'package:flutter/material.dart';

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  _CarrinhoScreenState createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final List<CartItem> cartItems = [
    CartItem(name: 'Pizza de Calabresa com Queijo', price: 35.60, quantity: 1),
    CartItem(name: 'Refrigerante Lata', price: 6.90, quantity: 2),
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
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produtos Selecionados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC54444),
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
            const Divider(
              color: Color(0xFF2B1C1C),
              thickness: 2,
              height: 20,
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
                    color: Color(0xFFC54444),
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
                Navigator.pushNamed(context, '/finalizar_pedido');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B1C1C),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Adiciona bordas arredondadas
              child: Image.asset(
                'assets/150x150.jpg', // Caminho para a imagem
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
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
                  Text(
                    'R\$${formatCurrency(item.price)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC54444),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF2B1C1C)),
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
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2B1C1C)),
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Lógica para ver mais detalhes do produto
                    },
                    child: const Text(
                      "Ver mais...",
                      style: TextStyle(
                        color: Color(0xFF2B1C1C),
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
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFF2B1C1C)),
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
