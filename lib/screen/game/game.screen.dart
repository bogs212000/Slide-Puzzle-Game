import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<List<int?>> grid = [];
  final int gridSize = 4; // Grid size (4x4)
  int moveCount = 0; // Move counter
  int elapsedSeconds = 0; // Timer in seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeGame();
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
        showWinDialog();
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

  void showWinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text(
              'You solved the puzzle in $moveCount moves and $elapsedSeconds seconds!'),
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Puzzle'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Moves: $moveCount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Time: ${elapsedSeconds}s',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: tile == null ? Colors.grey : Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tile?.toString() ?? '',
                            style:
                            TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: initializeGame,
        child: Icon(Icons.refresh),
      ),
    );
  }
}