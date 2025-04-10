import 'package:flutter/material.dart';

class ResumoTarefasPage extends StatelessWidget {
  final List<Map<String, dynamic>> tarefas;

  const ResumoTarefasPage({super.key, required this.tarefas});

  @override
  Widget build(BuildContext context) {
    final total = tarefas.length;
    final concluidas = tarefas.where((t) => t['concluida']).length;
    final pendentes = total - concluidas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildResumoBox('Total de Tarefas', total, Colors.blue, context),
            const SizedBox(height: 16),
            _buildResumoBox('Concluídas', concluidas, Colors.green, context),
            const SizedBox(height: 16),
            _buildResumoBox('Pendentes', pendentes, Colors.orange, context),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoBox(String titulo, int valor, Color cor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            valor.toString(),
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
