import 'dart:async';
import 'package:assistencia_os/sync/core/sync_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// listener genérico
import 'dart:async'; // Necessário para o Completer
// ... seus outros imports

class SyncListener {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get user => FirebaseAuth.instance.currentUser;
  String? get uid => user?.uid;
  final List<StreamSubscription> subs = [];

  // 🔥 Agora retorna Future<void>
  Future<void> listen<T>({
    required String collection,
    required Future<T?> Function(int) getLocal,
    required Future<void> Function(T) putLocal,
    required Future<void> Function(int) deleteLocal,
    required T Function(Map<String, dynamic>, int) fromFirestore,
    DateTime? Function(T)? getUpdatedAtLocal,
  }) {
    // Retorna um Future completo imediatamente se não houver usuário
    if (uid == null) return Future.value();

    // 🌟 Cria o Completer
    final completer = Completer<void>();
    bool isFirstSnapshot = true;
    late StreamSubscription sub;

    sub = firestore
        .collection('users')
        .doc(uid!)
        .collection(collection)
        .snapshots()
        .listen(
          (snapshot) async {
        for (final change in snapshot.docChanges) {
          try {
            final data = change.doc.data();
            if (data == null) continue;

            final id = int.tryParse(change.doc.id);
            if (id == null) continue;

            final local = await getLocal(id);

            if (change.type == DocumentChangeType.removed) {
              if (local != null) await deleteLocal(id);
              continue;
            }

            final remoteUpdated = parseDate(data['updatedAt']);
            final localUpdated = (local != null && getUpdatedAtLocal != null)
                ? getUpdatedAtLocal(local)
                : null;

            if (local == null ||
                localUpdated == null ||
                (remoteUpdated != null &&
                    remoteUpdated.isAfter(localUpdated))) {
              await putLocal(fromFirestore(data, id));
            }
          } catch (e, st) {
            _logError(collection, e, st);
          }
        }

        // 🌟 Se for o primeiro lote de dados, avisa que terminou!
        if (isFirstSnapshot) {
          isFirstSnapshot = false;
          if (!completer.isCompleted) {
            completer.complete();
          }
        }
      },
      onError: (error, stack) async {
        _logError(collection, error, stack);

        // Se der erro no primeiro carregamento, encerra o completer com erro
        if (isFirstSnapshot && !completer.isCompleted) {
          completer.completeError(error);
        }

        await Future.delayed(const Duration(seconds: 5));
        await sub.cancel();

        // Cuidado com chamadas recursivas infinitas aqui, mas mantido como no seu original
        listen<T>(
          collection: collection,
          getLocal: getLocal,
          putLocal: putLocal,
          deleteLocal: deleteLocal,
          fromFirestore: fromFirestore,
          getUpdatedAtLocal: getUpdatedAtLocal,
        );
      },
      cancelOnError: false,
    );

    subs.add(sub);

    // 🌟 Retorna o Future do completer
    return completer.future;
  }

  void _logError(String collection, Object error, StackTrace? stack) {
    debugPrint('🔥 [Sync][$collection] $error');
    if (stack != null) debugPrint(stack.toString());
  }

  Future<void> cancelAll() async {
    for (final s in subs) {
      await s.cancel();
    }
    subs.clear();
  }
// ... resto da sua classe ...
}



// import 'dart:async';
// import 'dart:io'; // Necessário para Platform.isWindows
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:assistencia_os/sync/core/sync_utils.dart';
//
// import 'dart:async';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
//
// import '../../services/firestore_http_service.dart';
//
// // ⚠️ IMPORTANTE: Importe o arquivo onde você salvou a classe FirestoreHttpService
// // import 'caminho/para/o/firestore_http_service.dart';
//
// class SyncListener {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   User? get user => FirebaseAuth.instance.currentUser;
//   String? get uid => user?.uid;
//   final List<StreamSubscription> subs = [];
//
//   Future<void> listen<T>({
//     required String collection,
//     required Future<T?> Function(int) getLocal,
//     required Future<void> Function(T) putLocal,
//     required Future<void> Function(int) deleteLocal,
//     required T Function(Map<String, dynamic>, int) fromFirestore,
//     DateTime? Function(T)? getUpdatedAtLocal,
//   }) async {
//     if (uid == null) return Future.value();
//
//     // =======================================================
//     // 💻 ROTA WINDOWS (Segura via API REST HTTP)
//     // =======================================================
//     // if (Platform.isWindows) {
//     //   try {
//     //     debugPrint('🌐 [Sync][$collection] Baixando via HTTP no Windows...');
//     //
//     //     // 1. Instancia o nosso serviço seguro
//     //     final httpService = FirestoreHttpService();
//     //
//     //     // 2. Faz o download da coleção inteira (já vem limpo e em formato de Mapa)
//     //     final List<Map<String, dynamic>> docsNuvem = await httpService.getCollection(collection);
//     //
//     //     for (final data in docsNuvem) {
//     //       try {
//     //         // O serviço HTTP injeta o ID do documento dentro da chave 'id'
//     //         final idString = data['id'];
//     //         if (idString == null) continue;
//     //
//     //         final id = int.tryParse(idString.toString());
//     //         if (id == null) continue;
//     //
//     //         final local = await getLocal(id);
//     //         final remoteUpdated = parseDate(data['updatedAt']); // Usa sua função parseDate
//     //         final localUpdated = (local != null && getUpdatedAtLocal != null)
//     //             ? getUpdatedAtLocal(local)
//     //             : null;
//     //
//     //         // Lógica de atualização (Exatamente igual à sua original)
//     //         if (local == null ||
//     //             localUpdated == null ||
//     //             (remoteUpdated != null && remoteUpdated.isAfter(localUpdated))) {
//     //           await putLocal(fromFirestore(data, id));
//     //         }
//     //       } catch (e, st) {
//     //         _logError(collection, e, st);
//     //       }
//     //     }
//     //     debugPrint('✅ [Sync][$collection] Download HTTP concluído!');
//     //   } catch (e, st) {
//     //     _logError(collection, e, st);
//     //   }
//     //   return Future.value(); // Finaliza imediatamente após a leitura
//     // }
//
//     // =======================================================
//     // 📱 ROTA ANDROID/iOS (Tempo real nativo mantido!)
//     // =======================================================
//     final completer = Completer<void>();
//     bool isFirstSnapshot = true;
//     late StreamSubscription sub;
//
//     sub = firestore
//         .collection('users')
//         .doc(uid!)
//         .collection(collection)
//         .snapshots()
//         .listen(
//           (snapshot) async {
//         for (final change in snapshot.docChanges) {
//           try {
//             final data = change.doc.data();
//             if (data == null) continue;
//
//             final id = int.tryParse(change.doc.id);
//             if (id == null) continue;
//
//             final local = await getLocal(id);
//
//             if (change.type == DocumentChangeType.removed) {
//               if (local != null) await deleteLocal(id);
//               continue;
//             }
//
//             final remoteUpdated = parseDate(data['updatedAt']);
//             final localUpdated = (local != null && getUpdatedAtLocal != null)
//                 ? getUpdatedAtLocal(local)
//                 : null;
//
//             if (local == null ||
//                 localUpdated == null ||
//                 (remoteUpdated != null &&
//                     remoteUpdated.isAfter(localUpdated))) {
//               await putLocal(fromFirestore(data, id));
//             }
//           } catch (e, st) {
//             _logError(collection, e, st);
//           }
//         }
//
//         if (isFirstSnapshot) {
//           isFirstSnapshot = false;
//           if (!completer.isCompleted) {
//             completer.complete();
//           }
//         }
//       },
//       onError: (error, stack) async {
//         _logError(collection, error, stack);
//
//         if (isFirstSnapshot && !completer.isCompleted) {
//           completer.completeError(error);
//         }
//
//         await Future.delayed(const Duration(seconds: 5));
//         await sub.cancel();
//
//         listen<T>(
//           collection: collection,
//           getLocal: getLocal,
//           putLocal: putLocal,
//           deleteLocal: deleteLocal,
//           fromFirestore: fromFirestore,
//           getUpdatedAtLocal: getUpdatedAtLocal,
//         );
//       },
//       cancelOnError: false,
//     );
//
//     subs.add(sub);
//     return completer.future;
//   }
//
//   void _logError(String collection, Object error, StackTrace? stack) {
//     debugPrint('🔥 [Sync][$collection] $error');
//     if (stack != null) debugPrint(stack.toString());
//   }
//
//   Future<void> cancelAll() async {
//     for (final s in subs) {
//       await s.cancel();
//     }
//     subs.clear();
//   }
// }
