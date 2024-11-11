import 'package:flutter/material.dart';

class Section5Screen extends StatefulWidget {
  @override
  Section5 createState() => Section5();
}

class Section5 extends State<Section5Screen> {
  List<String?> selectedUnits = [null, null, null];

  void _selectUnit(int rowIndex, String unit) {
    setState(() {
      selectedUnits[rowIndex] = unit;
      if (rowIndex == 1) {
        value1 = unit;
      }
      else if (rowIndex == 2) {
        value2 = unit;
        conversion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'Валюта',
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        backgroundColor: Color.fromRGBO(51, 51, 51, 1.0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(vertical: 1),
            alignment: Alignment.center,
            width: 380,
            height: 70,
            decoration: BoxDecoration(
              color: Color.fromRGBO(218, 119, 14, 1.0),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.orange, width: 2.5),
            ),
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          BuildButtonRow(['USD', 'EUR', 'GBP', 'RUB', 'CNY'], 1),

          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(vertical: 1),
            alignment: Alignment.center,
            width: 380,
            height: 70,
            decoration: BoxDecoration(
              color: Color.fromRGBO(115, 115, 115, 1.0),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey, width: 2.5),
            ),
            child: Text(
              '$answer',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          BuildButtonRow(['USD', 'EUR', 'GBP', 'RUB', 'CNY'], 2),

          BuildButtonRow(['7', '8', '9'], 0),
          BuildButtonRow(['4', '5', '6'], 0),
          BuildButtonRow(['1', '2', '3'], 0),
          BuildButtonRow(['0', '.', 'AC'], 0),
        ],
      ),
    );
  }

  Widget BuildButtonRow(List<String> buttons, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return ButtonStyle(button, rowIndex);
      }).toList(),
    );
  }

  Widget ButtonStyle(String label, int rowIndex) {

    Color sCol = Color.fromRGBO(218, 119, 14, 0);
    if (selectedUnits[rowIndex] == label && ['USD', 'EUR', 'GBP', 'RUB', 'CNY'].contains(label)) {
      sCol = Color.fromRGBO(13, 191, 28, 1.0);
    }

    BoxDecoration boxStyle = BoxDecoration(
      color: Color.fromRGBO(218, 119, 14, 1.0),
      borderRadius: BorderRadius.circular(35),
    );
    double valButWidth = 85;
    double valButHeight = 85;;
    double valButFontSize = 35;
    EdgeInsets marginBut = EdgeInsets.all(8);

    if (label == '.' || label == 'AC') {
      sCol = Color.fromRGBO(115, 115, 115, 1.0);
      boxStyle = BoxDecoration(
        color: sCol,
        borderRadius: BorderRadius.circular(35),
      );
    }

    if (['USD', 'EUR', 'GBP', 'RUB', 'CNY'].contains(label)) {
      valButWidth = 60;
      valButHeight = 60;
      valButFontSize = 20;
      marginBut = EdgeInsets.symmetric(vertical: 35, horizontal:  10);
      boxStyle = BoxDecoration(
        border: Border.all(color: Color.fromRGBO(218, 119, 14, 1.0), width: 2),
        color: sCol,
        borderRadius: BorderRadius.circular(12),
      );
    }

    return GestureDetector(
      onTap: () {
        _selectUnit(rowIndex, label);
        conversion();
        if (rowIndex == 1)
          value1 = label;
        else if (rowIndex == 2)
          value2 = label;

        if (checkSymbol(label) == true) {
          if (label == 'AC') {
            ClearAll();
          }
          else {
            if (text == '0')
              text = label;
            else
              text += label;
          }
          conversion();
        }
      },

      child: Container(
        margin: marginBut,
        width: valButWidth,
        height: valButHeight,
        alignment: Alignment.center,
        decoration: boxStyle,
        child: Text(
          label,
          style: TextStyle(
            fontSize: valButFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  dynamic text ='0';
  dynamic answer = '0';

  dynamic value1 = 0;
  dynamic value2 = 0;

  Map<String, double> unitConversionFactors = {
    'USD': 1.0,
    'EUR': 0.92305,
    'GBP': 0.77325,
    'RUB': 97.55,
    'CNY': 7.12,
  };

  bool checkSymbol(String label) {
    if (['USD', 'EUR', 'GBP', 'RUB', 'CNY'].contains(label))
      return false;
    return true;
  }

  void conversion () {
    double writtenNumb = double.parse(text);
    double baseValue = toDollars(writtenNumb, value1);
    double convertedValue = baseValue * unitConversionFactors[value2]!;
    setState(() {
      answer = convertedValue.toStringAsFixed(2);
    });
  }

  double toDollars(value, String unit) {
    double ans = value / unitConversionFactors[unit];
    return ans;
  }

  void ClearAll() {
    text ='0';
    answer = '0';
  }
}