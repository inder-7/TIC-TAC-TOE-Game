import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int filledBoxes = 0;
  int exScore = 0, ohScore = 0;
  bool ohTurn = false;
  List<String> displayExOh = List.filled(9, '');

  final TextStyle myTextStyle = GoogleFonts.pressStart2p(
    color: Colors.grey.shade300,
    fontSize: 20,
  );

  final TextStyle gridTextStyle = GoogleFonts.pressStart2p(
    color: Colors.grey.shade300,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("PLAYER X", style: myTextStyle),
                        Text(exScore.toString(), style: myTextStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("PLAYER O", style: myTextStyle),
                        Text(ohScore.toString(), style: myTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _tapped(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: gridTextStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _tapped(int index) {
    if (displayExOh[index] == '') {
      setState(() {
        displayExOh[index] = ohTurn ? 'O' : 'X';
        filledBoxes += 1;
        ohTurn = !ohTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (displayExOh[i] == displayExOh[i + 1] &&
          displayExOh[i] == displayExOh[i + 2] &&
          displayExOh[i] != '') {
        _showWinDialog(displayExOh[i]);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (displayExOh[i] == displayExOh[i + 3] &&
          displayExOh[i] == displayExOh[i + 6] &&
          displayExOh[i] != '') {
        _showWinDialog(displayExOh[i]);
        return;
      }
    }

    // Check diagonals
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
      return;
    }
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
      return;
    }

    // Check for draw
    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "WINNER is $winner",
            style: myTextStyle,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text(
                "PLAY AGAIN",
                style: myTextStyle,
              ),
            ),
          ],
        );
      },
    );

    if (winner == 'O') {
      ohScore += 1;
    } else {
      exScore += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "DRAW",
            style: myTextStyle,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text(
                "PLAY AGAIN",
                style: myTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      displayExOh = List.filled(9, '');
      filledBoxes = 0;
    });
  }
}
