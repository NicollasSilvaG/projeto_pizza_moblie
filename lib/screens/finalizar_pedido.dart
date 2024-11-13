import 'package:flutter/material.dart'; 

class FinalizarPedidoScreen extends StatefulWidget {
  const FinalizarPedidoScreen({super.key});

  @override
  _FinalizarPedidoScreenState createState() => _FinalizarPedidoScreenState();
}

class _FinalizarPedidoScreenState extends State<FinalizarPedidoScreen> {
  bool isDelivery = false;
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _addressPopupController = TextEditingController();
  double deliveryFee = 5.00;
  String paymentMethod = 'Dinheiro';

  // Dados estáticos de endereço (exemplo)
  String userAddress = 'Heloísa Ribeiro\n(+55) 11 99150-3750\nR PH Guilherme B Sabino, 1347, 41, São Paulo, São Paulo, 04678-002';

  // Lista de cupons resgatados
  List<String> userCoupons = ['CUPOM10', 'DESCONTO5', 'FRETEGRATIS'];
  String? selectedCoupon;

  // Dados do pedido
  double productSubtotal = 27.67;
  double couponDiscount = 10.00;

  void _showEditAddressPopup() {
    _addressPopupController.text = userAddress;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Endereço"),
          content: TextField(
            controller: _addressPopupController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Endereço',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Salvar"),
              onPressed: () {
                setState(() {
                  userAddress = _addressPopupController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPayment = productSubtotal + (isDelivery ? deliveryFee : 0) - couponDiscount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Pedido'),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Opções de Retirada ou Entrega
            const Text(
              'Opções de Entrega',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store, color: Color(0xFF2B1C1C)),
                      SizedBox(width: 8),
                      Text('Retirada na Loja'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32.0, top: 4.0),
                    child: Text(
                      'Ao selecionar esta opção, você poderá retirar o produto diretamente na nossa loja física.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              value: false,
              groupValue: isDelivery,
              onChanged: (bool? value) {
                setState(() {
                  isDelivery = value ?? false;
                });
              },
            ),
            RadioListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.home, color: Color(0xFF2B1C1C)),
                      SizedBox(width: 8),
                      Text('Entrega em Domicílio'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32.0, top: 4.0),
                    child: Text(
                      'Ao selecionar esta opção, o produto será entregue diretamente no seu endereço.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              value: true,
              groupValue: isDelivery,
              onChanged: (bool? value) {
                setState(() {
                  isDelivery = value ?? true;
                });
              },
            ),

            if (isDelivery) ...[
              const SizedBox(height: 16),
              // Exibição do endereço com botão Editar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Endereço de Entrega',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _showEditAddressPopup,
                    child: const Text(
                      "EDITAR",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  userAddress,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Taxa de Entrega: R\$${deliveryFee.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 16),

            // Seleção de Cupom de Desconto
            const Row(
              children: [
                Icon(Icons.discount, color: Color(0xFF2B1C1C)),
                SizedBox(width: 8),
                Text(
                  'Cupom de Desconto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              hint: const Text("Selecione um cupom"),
              value: selectedCoupon,
              items: userCoupons.map((String coupon) {
                return DropdownMenuItem<String>(
                  value: coupon,
                  child: Text(coupon),
                );
              }).toList(),
              onChanged: (String? newCoupon) {
                setState(() {
                  selectedCoupon = newCoupon;
                  _couponController.text = newCoupon ?? '';
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _couponController,
              decoration: const InputDecoration(
                labelText: 'Ou insira um cupom',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  selectedCoupon = null;
                });
              },
            ),

            const SizedBox(height: 16),

            // Opções de Pagamento
            const Row(
              children: [
                Icon(Icons.payment, color: Color(0xFF2B1C1C)),
                SizedBox(width: 8),
                Text(
                  'Forma de Pagamento',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            DropdownButton<String>(
              value: paymentMethod,
              items: <String>['Dinheiro', 'Cartão de Crédito', 'Cartão de Débito'].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (String? newMethod) {
                setState(() {
                  paymentMethod = newMethod ?? 'Dinheiro';
                });
              },
            ),

            const SizedBox(height: 16),

            // Resumo do Pedido
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow("Subtotal dos Produtos", productSubtotal),
                _buildSummaryRow("Sub-total do Frete", isDelivery ? deliveryFee : 0),
                _buildSummaryRow("Cupom de desconto", -couponDiscount),
                Divider(color: Colors.grey[400]),
                _buildSummaryRow("Pagamento Total", totalPayment, isTotal: true),
              ],
            ),

            const SizedBox(height: 16),

            // Botão para Confirmar Pedido
            ElevatedButton(
              onPressed: () {
                // Lógica para confirmar o pedido
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
                  'FAZER PEDIDO',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
          Text(
            "R\$${value.toStringAsFixed(2).replaceAll('.', ',')}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
