import 'package:flutter/material.dart';

// Tela de resumo das tarefas
class ResumoTarefasPage extends StatelessWidget {
  // Lista de tarefas recebidas como parâmetro
  final List<Map<String, dynamic>> tarefas;

  const ResumoTarefasPage({super.key, required this.tarefas});

  @override
  Widget build(BuildContext context) {
    // Calcula o total de tarefas
    final total = tarefas.length;

    // Filtra as tarefas que estão concluídas
    final concluidas = tarefas.where((t) => t['concluida']).length;

    // Calcula as tarefas que ainda estão pendentes
    final pendentes = total - concluidas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo'), // Título da AppBar
        centerTitle: true, // Centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(24), // Espaçamento interno da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bloco de resumo: total de tarefas
            _buildResumoBox('Total de Tarefas', total, Colors.blue, context),
            const SizedBox(height: 16), // Espaço entre os blocos

            // Bloco de resumo: tarefas concluídas
            _buildResumoBox('Concluídas', concluidas, Colors.green, context),
            const SizedBox(height: 16), // Espaço entre os blocos

            // Bloco de resumo: tarefas pendentes
            _buildResumoBox('Pendentes', pendentes, Colors.orange, context),
          ],
        ),
      ),
    );
  }

  // Widget que monta um "cartão" com o resumo de uma informação (ex: total de tarefas)
  Widget _buildResumoBox(String titulo, int valor, Color cor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24), // Espaçamento interno do cartão
      decoration: BoxDecoration(
        color: cor.withOpacity(0.85), // Cor de fundo com transparência
        borderRadius: BorderRadius.circular(16), // Arredondamento dos cantos
      ),
      child: Column(
        children: [
          Text(
            titulo, // Exibe o título (ex: "Concluídas")
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12), // Espaço entre título e valor
          Text(
            valor.toString(), // Mostra o número (quantidade)
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
