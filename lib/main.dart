// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:laboratorioapp/pages/home_laboratorio.dart';
import 'package:laboratorioapp/providers/hrayto_provider.dart';
import 'package:laboratorioapp/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String titleApp = 'laboratorioapp';
void main() {
  try {} catch (e) {
    print(e);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UrlProvider()),
        ChangeNotifierProvider(create: (context) => HRaytoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titleApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Homelaboratorioapp(title: titleApp),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'), // English
      ],
    );
  }
}
