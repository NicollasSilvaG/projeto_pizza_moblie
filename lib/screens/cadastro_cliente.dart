import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/api_service.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({super.key});

  @override
  CadastroClienteScreenState createState() => CadastroClienteScreenState();
}

class CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmSenhaController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  String? selectedUf;

  final maskTelefone = MaskTextInputFormatter(mask: '(##) # ####-####');
  final maskCep = MaskTextInputFormatter(mask: '#####-###');

  final ApiService apiService = ApiService();

  Future<void> _onCadastrarPressed() async {
    final nome = nomeController.text;
    final email = emailController.text;
    final telefone = telefoneController.text;
    final senha = senhaController.text;
    final rua = ruaController.text;
    final cidade = cidadeController.text;
    final cep = cepController.text;
    final bairro = bairroController.text;
    final complemento = complementoController.text;
    final confirmSenha = confirmSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        telefone.isEmpty ||
        senha.isEmpty ||
        confirmSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios!')),
      );
      return;
    }
    if (senha != confirmSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem!')),
      );
      return;
    }

    try {
      await apiService.cadastrarUsuario(
        nome: nome,
        email: email,
        telefone: telefone,
        senha: senha,
        rua: rua,
        cidade: cidade,
        cep: cep,
        bairro: bairro,
        complemento: complemento,
        uf: selectedUf,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC54444),
      appBar: AppBar(
        title: const Text(
          'Cadastro de Cliente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2B1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Dados Obrigatórios',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Text(
              'Os campos abaixo são obrigatórios para concluir o cadastro. Preencha-os corretamente para prosseguir.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFFFD700),
              ),
              softWrap: true,
            ),
            const SizedBox(height: 10),

            // Nome
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.person, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Telefone
            TextField(
              controller: telefoneController,
              inputFormatters: [maskTelefone],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.phone, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Senha
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Confirmar Senha
            TextField(
              controller: confirmSenhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            ExpansionTile(
              title: const Text(
                'Dados de Endereço',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              leading: const Icon(Icons.location_on, color: Colors.white),
              children: [
                // Rua
                TextField(
                  controller: ruaController,
                  decoration: InputDecoration(
                    labelText: 'Rua',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon:
                        const Icon(Icons.location_on, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),

                // Complemento
                TextField(
                  controller: complementoController,
                  decoration: InputDecoration(
                    labelText: 'Complemento',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon:
                        const Icon(Icons.apartment, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),

                // Bairro
                TextField(
                  controller: bairroController,
                  decoration: InputDecoration(
                    labelText: 'Bairro',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.home, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),

                // Cidade
                TextField(
                  controller: cidadeController,
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon:
                        const Icon(Icons.location_city, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),

                // UF
                DropdownButtonFormField<String>(
                  value: selectedUf,
                  onChanged: (value) {
                    setState(() {
                      selectedUf = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Estado (UF)',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.flag, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: ['SP', 'RJ', 'MG', 'GO', 'BA', 'PR']
                      .map((uf) => DropdownMenuItem<String>(
                            value: uf,
                            child: Text(uf),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),

                // CEP
                TextField(
                  controller: cepController,
                  inputFormatters: [maskCep],
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.location_searching,
                        color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Botão de Cadastrar
            ElevatedButton(
              onPressed: _onCadastrarPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B1C1C),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
