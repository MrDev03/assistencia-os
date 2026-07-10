
import 'dart:io';

import 'package:assistencia_os/pages/auth/auth_gate.dart';
import 'package:assistencia_os/providers/badge_provider.dart';
import 'package:assistencia_os/providers/mobile_premium_provider.dart';
import 'package:assistencia_os/providers/notifier.dart';
import 'package:assistencia_os/theme/theme_data.dart';
import 'package:assistencia_os/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_helper/db_helper.dart';
import 'firebase_options.dart';


Future<void> main() async {

  try {
    WidgetsFlutterBinding.ensureInitialized();

    await DatabaseHelper.init();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    notifier.reset();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 🔥 ADICIONE ISTO AQUI: Desativa o cache no Windows para evitar o crash C++
    // if (Platform.isWindows) {
    //   FirebaseFirestore.instance.settings = const Settings(
    //     persistenceEnabled: false,
    //   );
    // }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => PremiumProvider()..init()), // inicia o provider
          ChangeNotifierProvider(create: (_) => BadgeProvider()),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    debugPrint("Erro durante a inicialização: $e");
    // Você pode rodar um "App de Erro" simples aqui se quiser
  }

  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.edgeToEdge,
  //   //SystemUiMode.immersiveSticky,
  // );
  //
  // await DatabaseHelper.init();
  //
  // notifier.reset();
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'), // Português do Brasil
        Locale('pt', 'PT'), // Português de Portugal
        Locale('en', 'US'), // Inglês
      ],
      title: 'Assistência OS',
      theme: lightThemeColor(themeProvider.corPrimaria),
      darkTheme: darkThemeColor(themeProvider.corPrimaria),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,

      // --- A CORREÇÃO ESTÁ AQUI ---
      // O 'builder' permite injetar widgets globais (como overlays e flushbars)
      // DENTRO do MaterialApp, garantindo que eles acedem às traduções.
      builder: (context, child) {
        return FlashyFlushbarProvider(
          child: child!,
        );
      },
      // -----------------------------

      home: const AuthGate(),
    );
  }
}

