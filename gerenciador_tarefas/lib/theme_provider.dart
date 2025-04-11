import 'package:flutter/material.dart';

// Classe responsável por gerenciar o tema do aplicativo (claro ou escuro)
class ThemeProvider extends ChangeNotifier {
  // Define o tema inicial como claro
  ThemeMode _themeMode = ThemeMode.light;

  // Getter para acessar o tema atual (usado pelo MaterialApp)
  ThemeMode get themeMode => _themeMode;

  // Getter que retorna true se o tema atual for escuro
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Função para alternar entre modo claro e escuro
  void toggleTheme(bool isOn) {
    // Se isOn for true, ativa modo escuro; senão, modo claro
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica widgets que escutam mudanças de tema
  }
}
