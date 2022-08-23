// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_mi_calculator/screens/extcalc.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbutton(String btntext, Color btncolor, Color txtcolor) {
    return FlatButton(
      onPressed: () {
        calculation(btntext);
      },
      shape: const CircleBorder(),
      color: btncolor,
      padding: const EdgeInsets.all(15),
      child: Text(
        btntext,
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.normal,
          color: txtcolor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Xaiomi Calculator'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black, fontSize: 55),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('AC', Colors.white, Colors.orange),
                  FlatButton(
                    onPressed: () {
                      if (text != null && text.length > 0) {
                        text = text.substring(0, text.length - 1);
                      }
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  calcbutton('%', Colors.white, Colors.orange),
                  calcbutton('/', Colors.white, Colors.orange),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('7', Colors.white, Colors.black),
                  calcbutton('8', Colors.white, Colors.black),
                  calcbutton('9', Colors.white, Colors.black),
                  calcbutton('x', Colors.white, Colors.orange),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('4', Colors.white, Colors.black),
                  calcbutton('5', Colors.white, Colors.black),
                  calcbutton('6', Colors.white, Colors.black),
                  calcbutton('-', Colors.white, Colors.orange),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('1', Colors.white, Colors.black),
                  calcbutton('2', Colors.white, Colors.black),
                  calcbutton('3', Colors.white, Colors.black),
                  calcbutton('+', Colors.white, Colors.orange),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const extcalc()));
                    },
                    child: const Icon(
                      Icons.crop_rotate_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  calcbutton('0', Colors.white, Colors.black),
                  calcbutton('.', Colors.white, Colors.black),
                  calcbutton('=', Colors.orange, Colors.white),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

//Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
