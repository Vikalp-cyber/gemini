import 'package:flutter/material.dart';
import 'package:gemini/textonly.dart';
import 'package:gemini/textwithimage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gemini",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              text: "Text Only",
            ),
            Tab(
              text: "Text and Image",
            )
          ]),
        ),
        body: const TabBarView(
          children: [TextOnly(), TextWithImage()],
        ),
      ),
    );
  }
}
