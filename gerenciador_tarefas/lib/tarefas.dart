import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resumo.dart';
import 'theme_provider.dart';

class ListaTarefasPage extends StatefulWidget {
  const ListaTarefasPage({super.key});

  @override
  State<ListaTarefasPage> createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  List<Map<String, dynamic>> tarefas = [
    {'titulo': 'Reunião da empresa', 'concluida': false},
    {'titulo': 'Buscar o carro na oficina', 'concluida': false},
    {'titulo': 'Renovar passaporte', 'concluida': false},
    {'titulo': 'Ir para o trabalho', 'concluida': false},
  ];

  final TextEditingController _novaTarefaController = TextEditingController();

  void _adicionarTarefa() {
    String novaTarefa = _novaTarefaController.text.trim();
    if (novaTarefa.isNotEmpty) {
      setState(() {
        tarefas.add({'titulo': novaTarefa, 'concluida': false});
        _novaTarefaController.clear();
      });
    }
  }

  void _alternarConclusao(int index) {
    setState(() {
      tarefas[index]['concluida'] = !tarefas[index]['concluida'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
            const ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Ajuda'),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Modo escuro'),
              secondary: const Icon(Icons.dark_mode),
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (val) {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(val);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  const Text(
                    'Minha Lista de Tarefas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.notifications_none),
                ],
              ),
            ),

            // LISTA DE TAREFAS
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      tarefas[index]['concluida']
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: tarefas[index]['concluida'] ? Colors.green : null,
                    ),
                    title: Text(
                      tarefas[index]['titulo'],
                      style: TextStyle(
                        decoration: tarefas[index]['concluida']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    onTap: () => _alternarConclusao(index),
                  );
                },
              ),
            ),

            // CAMPO DE ADIÇÃO DE TAREFA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _novaTarefaController,
                      decoration: const InputDecoration(hintText: 'Adicionar nova tarefa'),
                    ),
                  ),
                  IconButton(onPressed: _adicionarTarefa, icon: const Icon(Icons.add)),
                ],
              ),
            ),

            // BARRA INFERIOR
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tarefas'),
                BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Resumo'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
              ],
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumoTarefasPage(tarefas: tarefas),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
