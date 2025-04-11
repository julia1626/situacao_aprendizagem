import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Biblioteca para gerenciamento de estado
import 'theme_provider.dart'; // Importa o provedor de tema (claro/escuro)
import 'tarefas.dart'; // Importa a tela de tarefas (pós-login)
import 'login.dart'; // Importa a tela de login

// Função principal que inicia o app
void main() {
  runApp(
    // Provider para escutar mudanças no tema (claro/escuro)
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Cria o provedor de tema
      child: const MyApp(), // Executa o app
    ),
  );
}

// Widget principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Acesso ao tema atual (claro ou escuro)
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa "debug" no canto da tela
      title: 'Gerenciador de Tarefas', // Título do app

      // Define o modo do tema de acordo com o Provider
      themeMode: themeProvider.themeMode,

      // Tema claro
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),

      // Tema escuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),

      // Tela inicial: Login
      home: const LoginPage(),
    );
  }
}
