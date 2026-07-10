import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/mobile_premium_provider.dart';
import '../../sync/core/sync_service.dart';
import '../home/home.dart';
import 'login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  final SyncService _syncService = SyncService();
  User? _lastUser;
  bool _initializing = false;

  PremiumProvider? _premium;

  // 🔥 A TRAVA DE SEGURANÇA
  bool _isSyncRunning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 🔥 escuta mudanças da assinatura
    final premium = context.read<PremiumProvider>();
    if (_premium != premium) {
      _premium?.removeListener(_onPremiumChanged);
      _premium = premium;
      _premium!.addListener(_onPremiumChanged);
    }
  }

  void _onPremiumChanged() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_premium!.isPro) {
      PremiumHelper.salvarPremium(true);

      // Só inicia se ainda não estiver rodando
      if (!_isSyncRunning) {
        _isSyncRunning = true;
        debugPrint("🚀 Iniciando SyncService pela primeira vez...");
        _syncService.start();
      }
    } else {
      // Se perdeu o Pro, para o sync e destrava
      if (_isSyncRunning) {
        _isSyncRunning = false;
        debugPrint("🛑 Parando SyncService...");
        _syncService.stop();
      }
    }
  }

  @override
  void dispose() {
    _premium?.removeListener(_onPremiumChanged);
    _syncService.stop();
    super.dispose();
  }

  Future<void> _onLogin(User user) async {
    if (_initializing) return;
    _initializing = true;

    // 🔹 só inicia sync se já for premium
    //if (_premium?.isPro == true) {
    //await _syncService.start();
    //}

    _onPremiumChanged();

    _lastUser = user;
    _initializing = false;
  }

  Future<void> _onLogout() async {
    _lastUser = null;
    await _syncService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user != null && _lastUser?.uid != user.uid) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onLogin(user);
          });
        }

        if (user == null && _lastUser != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onLogout();
          });
        }

        return user != null
            ? const Home()
            : const LoginPage();
      },
    );
  }
}

