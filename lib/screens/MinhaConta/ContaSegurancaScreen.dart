import 'package:flutter/material.dart';

class ContaSegurancaScreen extends StatelessWidget {
  const ContaSegurancaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta & Segurança'),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Atualizar Perfil"),
            onTap: () {
              // Navegar para a tela de Atualizar Perfil
              Navigator.pushNamed(context, '/atualizar_perfil');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Alterar Endereço"),
            onTap: () {
              // Navegar para a tela de Alterar Endereço
              Navigator.pushNamed(context, '/alterar_endereco');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Alterar Senha"),
            onTap: () {
              // Navegar para a tela de Alterar Senha
              Navigator.pushNamed(context, '/alterar_senha');
            },
          ),
        ],
      ),
    );
  }
}
