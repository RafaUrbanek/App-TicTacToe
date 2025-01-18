import 'package:flutter/material.dart';
import 'tictactoe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App-TicTacToe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyPage(title: 'TicTacToe'),
    );
  }
}

class MyPage extends StatefulWidget {
  final String title;
  
  const MyPage({
    super.key,
    required this.title,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Top Space
          Expanded(
            flex: 1,
            child: Container(),
          ),
          //Midle Space
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //First Column
                Expanded(
                  child: Container(),
                ),
                //Second Column
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 5),
                        )
                      ],
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color.fromARGB(115, 3, 3, 3), width: 2),
                    ),
                    child: const TicTacToe(),
                  ),
                ),
                //Third Column
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          //Bottom Space
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }
}
