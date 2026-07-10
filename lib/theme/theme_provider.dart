import 'package:assistencia_os/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  TemaApp _tema = TemaApp.claro;
  Color _corPrimaria = Colors.deepPurple;

  TemaApp get tema => _tema;
  Color get corPrimaria => _corPrimaria;

  ThemeProvider() {
    carregarPreferencias();
  }

  Future<void> carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _tema = TemaApp.values[prefs.getInt('temaApp') ?? 0];
    _corPrimaria = Color(prefs.getInt('corApp') ?? Colors.deepPurple.toARGB32());
    notifyListeners();
  }

  Future<void> alterarTema(TemaApp novoTema) async {
    _tema = novoTema;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('temaApp', novoTema.index);
    notifyListeners();
  }

  Future<void> alterarCor(Color novaCor) async {
    _corPrimaria = novaCor;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('corApp', novaCor.toARGB32());
    notifyListeners();
  }

  ThemeMode get themeMode {
    switch (_tema) {
      case TemaApp.claro:
        return ThemeMode.light;
      case TemaApp.escuro:
        return ThemeMode.dark;
      case TemaApp.sistema:
      return ThemeMode.system;
    }
  }
}
