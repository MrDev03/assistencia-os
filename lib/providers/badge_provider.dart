import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeProvider extends ChangeNotifier {
  // A chave que usaremos para salvar no disco
  static const String _storageKey = 'features_ja_vistas';

  // Todas as novidades que o app tem atualmente.
  final Set<String> _novidadesNaoVistas = {
    'tec',
    'ate',
    'for',
  };

  BadgeProvider() {
    // Assim que o Provider é criado ao abrir o app, ele busca o que já foi visto
    _carregarDadosLocais();
  }

  Future<void> _carregarDadosLocais() async {
    final prefs = await SharedPreferences.getInstance();

    // Puxa a lista de IDs que o usuário já clicou no passado
    final List<String> vistas = prefs.getStringList(_storageKey) ?? [];

    // Remove da nossa lista de "Não Vistas" tudo o que ele já viu
    _novidadesNaoVistas.removeAll(vistas);

    // Atualiza a tela (os badges somem imediatamente ao abrir o app)
    notifyListeners();
  }

  bool temNovidade(String featureId) {
    return _novidadesNaoVistas.contains(featureId);
  }

  Future<void> marcarComoVisto(String featureId) async {
    if (_novidadesNaoVistas.contains(featureId)) {
      // 1. Tira da tela na mesma hora
      _novidadesNaoVistas.remove(featureId);
      notifyListeners();

      // 2. Salva no disco do aparelho para não voltar quando reiniciar
      final prefs = await SharedPreferences.getInstance();

      // Pega a lista atual do disco, adiciona o novo ID e salva por cima
      List<String> vistasAtuais = prefs.getStringList(_storageKey) ?? [];
      if (!vistasAtuais.contains(featureId)) {
        vistasAtuais.add(featureId);
        await prefs.setStringList(_storageKey, vistasAtuais);
      }
    }
  }
}