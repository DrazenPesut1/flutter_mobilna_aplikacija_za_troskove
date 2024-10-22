import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("HomePage", style: TextStyle(fontSize: 50.0))),
      bottomNavigationBar: NavigationBar(destinations: const [Icon(Icons.house_rounded), Icon(Icons.abc)],)
    );
  }
}