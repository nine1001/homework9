import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework9/GameGuess.dart';

class GamePage extends StatefulWidget {
  GamePage({
    Key? key,
  }) : super(key: key);

  @override
  _GamePagestate createState() => _GamePagestate();
}

class _GamePagestate extends State<GamePage> {
  GameGuess? randomNumber;
  var inputGuessField = TextEditingController();
  var listGuess = <int>[];
  String inputNumber = "";
  var isCorrect = false;

  @override
  void initState() {
    super.setState(() {
      randomNumber = GameGuess();
    });
  }

  void onClickEnter(String number) {
    int? guessNumber = int.tryParse(number);
    setState(() {
      if (guessNumber == null) {
        inputNumber = "Try not to put empty";
      } else {
        inputNumber = number;
        listGuess.add(guessNumber);
        if (guessNumber == randomNumber!.answerNumber) {
          isCorrect = true;
          _showMaterialDialog();
        }
        randomNumber!.settotalcounter();
      }
    });
  }

  void onClickNewGame() {
    setState(() {
      initState();
      isCorrect = false;
      inputGuessField.clear();
      listGuess.clear();
    });
  }

  String checkNumber(String num) {
    int? number = int.tryParse(num);
    int? answer = randomNumber!.answerNumber;
    if (number! > answer!) {
      return "Too High";
    } else {
      return "Too low";
    }
  }
  String getHistory() {
    String his = "";
    int count = 1;
    listGuess.forEach((element) {
      if(count == listGuess.length)
        {
          his = his + " $element";
        }
      else {
        his = his + "$element -> ";

      }
      count++;
    });
    return his;
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("GOOD JOB!"),
          content:
              Text("The answer is ${randomNumber!.answerNumber}\nYou have made ${randomNumber!.totalcounter} guesses\n\n${getHistory()}"

             ),


          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget _inputfield() {
    return Card(
        margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
        borderOnForeground: true,
        child: SizedBox(
            height: 50,
            width: 300,
            child: TextField(
              controller: inputGuessField,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.pink,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.red,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter the number here',
                hintStyle: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16.0,
                ),
              ),
            )));
  }

  Widget _imageShow() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Image(
        image: AssetImage("assets/images/Guessnumber.png"),
        width: 300,
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
        onPressed: () {
          if(int.tryParse(inputGuessField.text) != null) {
            onClickEnter(inputGuessField.text);
            inputGuessField.clear();
          }
        },
        child: Text(
          "Enter",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ));
  }

  Widget _textShow() {
    return listGuess.isEmpty
        ? Text(
            "Guess number between 1 - 100",
            style: TextStyle(
                fontSize: 30,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold),
          )
        : _checkInputNumber();
  }

  Widget _checkInputNumber() {
    return isCorrect
        ? Column(
            children: [
              Container(
                child: Text(
                  inputNumber,
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                child: Text(
                  "Correct",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () => onClickNewGame(),
                  child: Text("New Game"),
                ),
              )
            ],
          )
        : Column(
            children: [
              Container(
                child: Text(
                  inputNumber,
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                child: Text(
                  checkNumber(inputNumber),
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS THE NUMBER"),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.lime),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: _imageShow(),
            )),
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: _textShow(),
            )),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [_inputfield(), _textButton()],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
