import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_one/model/player_model.dart';
import 'package:sample_one/view/pages/home/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlayerModelAdapter().typeId)) {
    Hive.registerAdapter(PlayerModelAdapter());
  }

  await Hive.openBox<PlayerModel>('players');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
