import 'package:flutter/material.dart';
import 'dart:math';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _board = List.filled(9, '');
  String _player = 'X';
  bool _computerPlayer = false;
  final Random _rand = Random();

  void _startMatch() {
    setState(() {
      _board = List.filled(9, '');
      _player = 'X';
    });
  }

  void _changePlayer() {
    setState(() {
      _player = _player == 'X' ? 'O' : 'X';
    });
  }

  void _winnersDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(winner == 'Draw' ? 'Draw!' : 'Winner: $winner Player'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[100],
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _startMatch();
              },
              child: const Text('Restart Game',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  bool _checkWinner(String player) {
    const winnerPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var positions in winnerPositions) {
      if (_board[positions[0]] == player &&
          _board[positions[1]] == player &&
          _board[positions[2]] == player) {
        _winnersDialog(player);
        return true;
      }
    }
    if (!_board.contains('')) {
      _winnersDialog('Draw');
      return true;
    }
    return false;
  }

  void _computerMove() {
    Future.delayed(const Duration(milliseconds: 500), () {
      int moviment;
      do {
        moviment = _rand.nextInt(9);
      } while (_board[moviment] != '');
      setState(() {
        _board[moviment] = 'O';
        if (!_checkWinner(_player)) {
          _changePlayer();
        }
      });
    });
  }

  void _move(int index) {
    if (_board[index] == '') {
      setState(() {
        _board[index] = _player;
        if (!_checkWinner(_player)) {
          _changePlayer();
          if (_computerPlayer && _player == 'O') {
            _computerMove();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.5;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  activeTrackColor: Colors.teal,
                  activeColor: Colors.teal[100],
                  value: _computerPlayer,
                  onChanged: (value) {
                    setState(() {
                      _computerPlayer = value;
                      _startMatch();
                    });
                  },
                ),
              ),
              Text(_computerPlayer ? 'Player vs Computer' : 'Player vs Player',
                  style: const TextStyle(color: Colors.black)),
              const SizedBox(width: 30.0),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: SizedBox(
            width: height,
            height: height,
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 10,right: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _move(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: const TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[100],
              ),
              onPressed: _startMatch,
              child: const Text('Restart Games',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
