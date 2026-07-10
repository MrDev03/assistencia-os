
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/sync/core/sync_guard.dart';
import 'package:assistencia_os/sync/core/sync_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../../providers/mobile_premium_provider.dart';
import '../modules/atendente_sync.dart';
import '../modules/cliente_sync.dart';
import '../modules/empresa_sync.dart';
import '../modules/estoque_pecas_sync.dart';
import '../modules/fornecedor_sync.dart';
import '../modules/servico_sync.dart';
import '../modules/tecnico_sync.dart';

// // orquestrador
// class SyncService {
//
//   final guard = SyncGuard();
//
//   final clienteSync = ClienteSync();
//   final servicoSync = ServicoSync();
//   final empresaSync = EmpresaSync();
//   final atendenteSync = AtendenteSync();
//   final tecnicoSync = TecnicoSync();
//   final fornecedorSync = FornecedorSync();
//   final estoquePecasSync = EstoquePecasSync();
//
//   final listener = SyncListener();
//
//   bool _starting = false;
//
//   PremiumProvider? _premium;
//
//   //final ValueNotifier<bool> loading = ValueNotifier(false);
//
//   Future<void> cancelListeners() async {
//     for (final subscription in List.of(listener.subs)) {
//       await subscription.cancel();
//       listener.subs.remove(subscription);
//     }
//     listener.subs.clear();
//   }
//
//   Future<void> start() async {
//     if (_starting) return;
//     _starting = true;
//
//     //SyncStatus.instance.start();
//
//     await cancelListeners();
//
//     // if (_premium?.isPro == false || _premium?.isPro == null) {
//     //   _starting = false;
//     //   SyncStatus.instance.stop();
//     //   AppFlushbar.error("Verifique sua conexão ou sua assinatura para sincronizar.");
//     //   return;
//     // }
//
//     //SyncStatus.instance.start();
//     //_starting = true;
//
//     empresaSync.listen();
//     clienteSync.listen();
//     atendenteSync.listen();
//     tecnicoSync.listen();
//     fornecedorSync.listen();
//     estoquePecasSync.listen();
//     servicoSync.listen();
//
//     //SyncStatus.instance.stop();
//   }
//
//   Future<void> stop() async {
//     if (!_starting) return;
//
//     //SyncStatus.instance.start();
//
//     await cancelListeners();
//
//     _starting = false;
//
//     //SyncStatus.instance.stop();
//   }
//
// }
import 'dart:io';
import 'package:flutter/foundation.dart'; // Para o debugPrint
// Lembre-se de importar o seu FirestoreHttpService quando criá-lo
// import 'caminho/para/o/firestore_http_service.dart';

class SyncService {
  final guard = SyncGuard();

  final clienteSync = ClienteSync();
  final servicoSync = ServicoSync();
  final empresaSync = EmpresaSync();
  final atendenteSync = AtendenteSync();
  final tecnicoSync = TecnicoSync();
  final fornecedorSync = FornecedorSync();
  final estoquePecasSync = EstoquePecasSync();

  final listener = SyncListener();

  bool _starting = false;
  PremiumProvider? _premium;

  Future<void> cancelListeners() async {
    for (final subscription in List.of(listener.subs)) {
      await subscription.cancel();
      listener.subs.remove(subscription);
    }
    listener.subs.clear();
  }

  Future<void> start() async {
    // Evita rodar a sincronização duas vezes ao mesmo tempo
    if (_starting) return;
    _starting = true;

    await cancelListeners();

    // 1. Liga a barra azul no topo da tela: "Sincronizando dados..."
    SyncStatus.instance.start();

    // =======================================================
    // 💻 ROTA WINDOWS (Segura via HTTP)
    // =======================================================
    if (Platform.isWindows) {
      debugPrint("🌐 Windows detectado: Iniciando sincronização HTTP...");

      await _syncWindowsViaHttp();

      // Como o HTTP faz um download único e termina, podemos desligar a barra aqui
      SyncStatus.instance.stop();
      _starting = false;
    }
    // =======================================================
    // 📱 ROTA MOBILE (Android/iOS via Firebase Nativo)
    // =======================================================
    else {
      debugPrint("📱 Mobile detectado: Iniciando Listeners do Firebase...");

      empresaSync.listen();
      clienteSync.listen();
      atendenteSync.listen();
      tecnicoSync.listen();
      fornecedorSync.listen();
      estoquePecasSync.listen();
      servicoSync.listen();

      // No mobile, os listeners ficam abertos "escutando" o banco indefinidamente.
      // Damos um pequeno tempo para a primeira carga acontecer e desligamos a barra.
      Future.delayed(const Duration(seconds: 2), () {
        SyncStatus.instance.stop();
        _starting = false;
      });
    }
  }

  Future<void> stop() async {
    if (!_starting) return;

    await cancelListeners();
    _starting = false;
    SyncStatus.instance.stop(); // Garante que a barra saia da tela
    debugPrint("🛑 Sincronização parada.");
  }

  // =======================================================
  // ⚙️ FUNÇÃO EXCLUSIVA DO WINDOWS
  // =======================================================
  // =======================================================
  // ⚙️ FUNÇÃO EXCLUSIVA DO WINDOWS (Agora é pra valer!)
  // =======================================================
  Future<void> _syncWindowsViaHttp() async {
    try {
      debugPrint("⬇️ Baixando coleções do Firebase via HTTP...");

      // Como nós alteramos o SyncListener para baixar via HTTP no Windows,
      // basta chamar o .listen() de cada um com "await".
      // Assim a barra de loading só vai sumir quando TODOS os dados terminarem de baixar!

      empresaSync.listen();
      clienteSync.listen();
      atendenteSync.listen();
      tecnicoSync.listen();
      fornecedorSync.listen();
      estoquePecasSync.listen();
      await servicoSync.listen();

      debugPrint("✅ Download HTTP do Windows concluído com sucesso!");
    } catch (e) {
      debugPrint("❌ Erro na sincronização do Windows: $e");
    }
  }
}

class SyncStatus {

  static final SyncStatus instance = SyncStatus._internal();

  SyncStatus._internal();

  final ValueNotifier<bool> syncing = ValueNotifier(false);

  void start() {
    syncing.value = true;
  }

  void stop() {
    syncing.value = false;
  }

}

class SyncOverlay extends StatelessWidget {
  const SyncOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Positioned fica por fora para o Stack reconhecê-logo de cara
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ValueListenableBuilder<bool>(
        valueListenable: SyncStatus.instance.syncing,
        builder: (context, syncing, child) {

          if (!syncing) return const SizedBox();

          // 2. SafeArea garante que a barra não fique escondida atrás do relógio/bateria no Android
          return SafeArea(
            child: Material(
              elevation: 4,
              child: Container(
                height: 40,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.cloud_download, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    const Text(
                      "Sincronizando dados...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

