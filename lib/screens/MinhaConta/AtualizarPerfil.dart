import 'package:flutter/material.dart';

class AtualizarPerfilScreen extends StatefulWidget {
  const AtualizarPerfilScreen({super.key});

  @override
  _AtualizarPerfilScreenState createState() => _AtualizarPerfilScreenState();
}

class _AtualizarPerfilScreenState extends State<AtualizarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Perfil'),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Processar a atualização do perfil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                    );
                    Navigator.pop(context); // Voltar para a tela anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC54444),
                ),
                child: const Text('Atualizar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
