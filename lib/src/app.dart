import 'package:flutter/material.dart';
import '../constantes/constantes.dart';
import 'pantallas/paginaPeliculas.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.light,
      home: const PaginaPeliculas(),
    );
  }
}
