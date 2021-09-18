import 'dart:math';

class GameGuess {
  int _counter = 0;
  int? answerNumber;
  GameGuess() : answerNumber = Random().nextInt(100)+1 {
    print("The answer is : ${answerNumber}");
  }
  int get totalcounter{
    return _counter;
  }
  void settotalcounter(){
    _counter++;
  }
}