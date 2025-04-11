import 'package:flutter/material.dart';
import 'tarefas.dart'; // Importa a tela de tarefas

// Define a tela de login como um widget sem estado
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura principal da tela
      body: Container(
        // Define o fundo com gradiente roxo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          // Centraliza os elementos verticalmente
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título do app
              const Text(
                'Gerenciador de tarefas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32), // Espaço entre o título e a caixa
              
              // Caixa de login
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Fundo cinza claro
                  borderRadius: BorderRadius.circular(24), // Cantos arredondados
                ),
                child: Column(
                  children: [
                    // Ícone do usuário
                    const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 16), // Espaço

                    // Campo de e-mail ou nome
                    _buildTextField(
                      label: 'E-mail ou Nome de Usuário',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),

                    // Campo de senha
                    _buildTextField(
                      label: 'Senha',
                      icon: Icons.lock_outline,
                      obscureText: true, // Esconde os caracteres digitados
                    ),
                    const SizedBox(height: 12),

                    // Botão "Esqueci minha senha"
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Aqui você pode adicionar uma ação futuramente
                        },
                        child: const Text(
                          'Esqueci a minha senha',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botão Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E24AA),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Ao clicar no login, vai para a tela de tarefas
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaTarefasPage()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar campos de texto personalizados
  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: label, // Texto de dica
        suffixIcon: Icon(icon), // Ícone no canto direito
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
