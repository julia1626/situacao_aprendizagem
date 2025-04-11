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
  // Lista de tarefas
  List<Map<String, dynamic>> tarefas = [
    {'titulo': 'Reunião da empresa', 'concluida': false},
    {'titulo': 'Buscar o carro na oficina', 'concluida': false},
    {'titulo': 'Renovar passaporte', 'concluida': false},
    {'titulo': 'Ir para o trabalho', 'concluida': false},
  ];

  // Controlador do campo de nova tarefa
  final TextEditingController _novaTarefaController = TextEditingController();

  // Adiciona uma nova tarefa na lista
  void _adicionarTarefa() {
    String novaTarefa = _novaTarefaController.text.trim();
    if (novaTarefa.isNotEmpty) {
      setState(() {
        tarefas.add({'titulo': novaTarefa, 'concluida': false});
        _novaTarefaController.clear();
      });
    }
  }

  // Alterna o estado de conclusão da tarefa
  void _alternarConclusao(int index) {
    setState(() {
      tarefas[index]['concluida'] = !tarefas[index]['concluida'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menu lateral (Drawer)
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Cabeçalho do menu
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

            // BOTÃO DASHBOARD (abre a tela de resumo)
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer antes de navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumoTarefasPage(tarefas: tarefas),
                  ),
                );
              },
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

            // Alternância de modo escuro
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

      // Corpo principal da tela
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão para abrir o menu lateral
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
                BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'DashBoard'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
              ],
              currentIndex: 0,
              onTap: (index) {
                // Quando clicar no item Resumo, abrir a página de resumo
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
