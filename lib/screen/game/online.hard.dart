import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:slide_puzzle/functions/play.functions.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/fonts.dart';
import '../../utils/images.dart';
import '../../utils/sounds.dart';
import '../auth/auth.wrapper.dart';
import '../home.screen.dart';

class OnlineHard extends StatefulWidget {
  @override
  _OnlineHardState createState() => _OnlineHardState();
}

class _OnlineHardState extends State<OnlineHard> {
  List<List<int?>> grid = [];
  final int gridSize = Get.arguments[1]; // Grid size (4x4)
  int moveCount = 0; // Move counter
  int elapsedSeconds = 0; // Timer in seconds
  int score = 0; // Score variable
  Timer? timer;

  final int baseScore = 10000; // Base score
  final int movePenalty = 10; // Penalty per move
  final int timePenalty = 5; // Penalty per second

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void calculateScore() {
    score =
        baseScore - (movePenalty * moveCount) - (timePenalty * elapsedSeconds);
    if (score < 0) score = 0; // Ensure score is not negative
    if(score == 0) showWinDialogZero();
    print(score);
  }
  void showWinDialogZero() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice!'),
          content: Text(
              "Too many moves! You've been playing this mode for a long time. Please try again!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                initializeGame(); // Restart the game
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void initializeGame() {
    // Reset the game
    moveCount = 0;
    elapsedSeconds = 0;

    // Stop any existing timer
    timer?.cancel();

    // Start a new timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });

    // Generate the list of numbers (1 to 15 and null for the empty space)
    List<int?> numbers = List.generate(gridSize * gridSize, (index) {
      return index < gridSize * gridSize - 1 ? index + 1 : null;
    });

    // Shuffle the numbers
    numbers.shuffle(Random());

    // Create the grid
    grid = List.generate(gridSize, (row) {
      return numbers.sublist(row * gridSize, (row + 1) * gridSize);
    });

    setState(() {});
  }

  List<int>? findEmptyTile() {
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] == null) {
          return [row, col];
        }
      }
    }
    return null;
  }

  void moveTile(int row, int col) {
    List<int>? emptyTile = findEmptyTile();
    if (emptyTile == null) return;

    int emptyRow = emptyTile[0];
    int emptyCol = emptyTile[1];

    // Check if the tapped tile is adjacent to the empty space
    if ((row == emptyRow && (col == emptyCol - 1 || col == emptyCol + 1)) ||
        (col == emptyCol && (row == emptyRow - 1 || row == emptyRow + 1))) {
      setState(() {
        // Swap the tapped tile with the empty space
        grid[emptyRow][emptyCol] = grid[row][col];
        grid[row][col] = null;
        moveCount++; // Increment the move counter
      });

      // Check if the user has won
      if (checkWinCondition()) {
        timer?.cancel();
        calculateScore();
        showWinDialog();
        addScore(score);
        addCountHardMode();
        win();
      }
    }
  }

  bool checkWinCondition() {
    int count = 1;
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (row == grid.length - 1 && col == grid[row].length - 1) {
          // The last tile should be null
          return grid[row][col] == null;
        }
        if (grid[row][col] != count) {
          return false;
        }
        count++;
      }
    }
    return true;
  }

  void exit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('Are you sure you want to exit game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.offAll(AuthWrapper());
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void showWinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text(
              'You solved the puzzle in $moveCount moves and $elapsedSeconds seconds!. $score Scores!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.offAll(AuthWrapper());
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                initializeGame(); // Restart the game
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  late AudioPlayer player = AudioPlayer();

  void tap() {
    player.play(AssetSource(AppSounds.tap));
  }

  void win() {
    player.play(AssetSource(AppSounds.win));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back using GetX
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Sliding Puzzle'),
        // ),
        body: VxBox(
          child: Column(
            children: [
              30.heightBox,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VxBox(
                      child: Row(
                        children: [
                          Icon(Icons.touch_app_outlined, color: Colors.green),
                          5.widthBox,
                          'Moves : '.text.fontFamily(Fonts.figtree).bold.make(),
                          '$moveCount'
                              .text
                              .fontFamily(Fonts.figtree)
                              .bold
                              .make(),
                        ],
                      ),
                    )
                        .padding(EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5))
                        .rounded
                        .border(color: Colors.green, width: 0.5)
                        .white
                        .make(),
                    IconButton(
                        onPressed: () {
                          exit();
                        },
                        icon: Icon(Icons.home_filled,
                            size: 30, color: Colors.green)),
                    VxBox(
                      child: Row(
                        children: [
                          Icon(Icons.timer, color: Colors.green),
                          5.widthBox,
                          'Timer : '.text.fontFamily(Fonts.figtree).bold.make(),
                          '${elapsedSeconds}s'
                              .text
                              .fontFamily(Fonts.figtree)
                              .bold
                              .make(),
                        ],
                      ),
                    )
                        .padding(EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5))
                        .rounded
                        .border(color: Colors.green, width: 0.5)
                        .white
                        .make(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    'Estimated Score ($baseScore - (10 * move count) - (5 * elapsed seconds)) : $score'
                        .text
                        .fontFamily(Fonts.figtree)
                        .size(10)
                        .white
                        .make(),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: grid.map((row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: row.map((tile) {
                          return GestureDetector(
                            onTap: tile == null
                                ? null
                                : () {
                                    // Get row and column of the tapped tile
                                    int rowIndex = grid.indexOf(row);
                                    int colIndex = row.indexOf(tile);
                                    moveTile(rowIndex, colIndex);
                                    calculateScore();
                                    tap();
                                  },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(1),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    tile == null ? Colors.grey : Colors.green,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                tile?.toString() ?? '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ).animate().fade(duration: 400.ms).scale(delay: 400.ms)
            ],
          ),
        )
            .height(MediaQuery.of(context).size.height)
            .width(MediaQuery.of(context).size.width)
            .bgImage(DecorationImage(
                image: AssetImage(Images.home_bg), fit: BoxFit.cover))
            .make(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: initializeGame,
        //   child: Icon(Icons.refresh),
        // ),
      ),
    );
  }
}
