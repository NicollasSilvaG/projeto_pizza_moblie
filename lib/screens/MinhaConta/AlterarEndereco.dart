import 'package:flutter/material.dart';

class AlterarEnderecoScreen extends StatefulWidget {
  const AlterarEnderecoScreen({super.key});

  @override
  _AlterarEnderecoScreenState createState() => _AlterarEnderecoScreenState();
}

class _AlterarEnderecoScreenState extends State<AlterarEnderecoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Endereço'),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu endereço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  prefixIcon: Icon(Icons.location_searching),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CEP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Processar a alteração do endereço
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Endereço alterado com sucesso!')),
                    );
                    Navigator.pop(context); // Voltar para a tela anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC54444),
                ),
                child: const Text('Alterar Endereço'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
