// lib/screens/application_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final Random random = Random();

  late int random1;
  late int random2;
  String result = "";
  int correct = 0;
  int incorrect = 0;
  Color resultColor = Colors.white;

  @override
  void initState() {
    super.initState();
    generateRandomNumbers();
  }

  void generateRandomNumbers() {
    setState(() {
      random1 = random.nextInt(100);
      random2 = random.nextInt(100);
    });
  }

  void checkNumbersLeftButton() {
    if (correct + incorrect < 10) {
      bool check = random1 > random2;
      displayResult(check);
    } else {
      showGameOverDialog();
    }
  }

  void checkNumbersRightButton() {
    if (correct + incorrect < 10) {
      bool check = random1 < random2;
      displayResult(check);
    } else {
      showGameOverDialog();
    }
  }

  void displayResult(bool check) {
    setState(() {
      if (check) {
        correct++;
      } else {
        incorrect++;
      }

      if (correct + incorrect == 10) {
        if (correct > 5) {
          result = "You won!!";
          resultColor = Colors.green;
        } else if (correct == 5 && incorrect == 5) {
          result = "Draw!!";
          resultColor = Colors.blue;
        } else {
          result = "You lose!!";
          resultColor = Colors.red;
        }
      } else {
        generateRandomNumbers();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Your Score: $correct / 10",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              correct > 5
                  ? "You Won!!"
                  : (correct == 5 && incorrect == 5)
                  ? "Draw!!"
                  : "You Lose!!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: correct > 5
                    ? Colors.green
                    : (correct == 5 && incorrect == 5)
                    ? Colors.blue
                    : Colors.red,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                resetGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Play Again"),
            ),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      correct = 0;
      incorrect = 0;
      resultColor = Colors.white;
      result = "";
    });
    generateRandomNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Number Generator Game")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 600,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Number Generator",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 125,
                    child: ElevatedButton(
                      onPressed: () {
                        checkNumbersLeftButton();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text("$random1"),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                    child: ElevatedButton(
                      onPressed: () {
                        checkNumbersRightButton();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text("$random2"),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 225,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Score",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Correct: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "$correct",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Incorrect: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "$incorrect",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: resultColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            result,
                            style: TextStyle(
                              fontSize: 18,
                              color: resultColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () {
                    resetGame();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
