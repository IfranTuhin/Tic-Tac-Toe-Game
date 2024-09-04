import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/utils/color_constrants.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.player1, required this.player2});

  String player1;
  String player2;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> board;
  late String currentPlayer;
  late String winner;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    board = List.generate(3, (index) => List.generate(3, (index) => ""));
    currentPlayer = 'X';
    winner = '';
    gameOver = false;
  }

  // Reset Game
  void resetGame() {
    setState(() {
      board = List.generate(3, (index) => List.generate(3, (index) => ""));
      currentPlayer = 'X';
      winner = '';
      gameOver = false;
    });
  }


  // Make Move
  void makeMove(int row, int col) {
    if (board[row][col] != '' || gameOver) {
      return;
    }
    setState(() {
      board[row][col] = currentPlayer;

      // Check for a winner
      if (board[row][0] == currentPlayer &&
          board[row][1] == currentPlayer &&
          board[row][2] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
      } else if (board[0][col] == currentPlayer &&
          board[1][col] == currentPlayer &&
          board[2][col] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
      } else if (board[0][0] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][2] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
      } else if (board[0][2] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][0] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
      }

      // Switch players
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';

      // Check for tie
      if (!board.any((row) => row.any((cell) => cell == ""))) {
        gameOver = true;
        winner = "It's a Tie";
      }

      // Show Awesome Dialog
      if (winner != '') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: 'Play Again',
          title: winner == 'X'
              ? '${widget.player1} Won!'
              : winner == 'O'
                  ? '${widget.player2} Won!'
                  : "It's a Tie",
          btnOkOnPress: () {
            resetGame();
          },
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConst.primaryColor,
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Turn : ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        currentPlayer == 'X'
                            ? "${widget.player1} ($currentPlayer)"
                            : "${widget.player2} ($currentPlayer)",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: currentPlayer == 'X'
                              ? const Color(0xFFE25041)
                              : const Color(0xFF1CBD9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            Container(
              alignment: Alignment.center, // Ensures the entire grid is centered
              decoration: BoxDecoration(
                color: const Color(0x0ff56884),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () {
                      makeMove(row, col);
                    },
                    child: Container(
                      alignment: Alignment.center, // Ensures the text inside is centered
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1E3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: board[row][col] == 'X'
                                ? const Color(0xFFE25041)
                                : const Color(0xFF1CBD9E),
                          ),
                          textAlign: TextAlign.center, // Ensures text is horizontally centered
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                resetGame();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Reset Game',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
