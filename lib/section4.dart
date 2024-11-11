import 'package:flutter/material.dart';

class Section4Screen extends StatefulWidget {
  @override
  Section4 createState() => Section4();
}

class Section4 extends State<Section4Screen> {
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
            'Температура',
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

          BuildButtonRow(['C', 'F', 'K'], 1),

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

          BuildButtonRow(['C', 'F', 'K'], 2),

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
    if (selectedUnits[rowIndex] == label && ['C', 'F', 'K'].contains(label)) {
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

    if (['C', 'F', 'K'].contains(label)) {
      valButWidth = 60;
      valButHeight = 60;
      valButFontSize = 25;
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
    'C': 1,
    'F': 33.8,
    'K': 274.15,
  };

  bool checkSymbol(String label) {
    if (['C', 'F', 'K'].contains(label))
      return false;
    return true;
  }

  void conversion () {
    double writtenNumb = double.parse(text);
    double convertedValue;
    if (value1 == 'F' && value2 == 'C')
      convertedValue = fahrenheitAndCelsius(writtenNumb, false);
    else if (value1 == 'K' && value2 == 'C')
      convertedValue = kelvinAndCelsius(writtenNumb, false);
    else if (value1 == 'C' && value2 == 'F')
      convertedValue = fahrenheitAndCelsius(writtenNumb, true);
    else if (value1 == 'C' && value2 == 'K')
      convertedValue = kelvinAndCelsius(writtenNumb, true);
    else if (value1 == 'F' && value2 == 'K') {
      convertedValue = fahrenheitAndCelsius(writtenNumb, false);
      convertedValue = kelvinAndCelsius(convertedValue, true);
    }
    else if (value1 == 'K' && value2 == 'F'){
      convertedValue = kelvinAndCelsius(writtenNumb, false);
      convertedValue = fahrenheitAndCelsius(convertedValue, true);
    }
    else
      convertedValue = writtenNumb;
    setState(() {
      answer = convertedValue.toStringAsFixed(1);
    });
  }

  double fahrenheitAndCelsius(value, check) {
    double ans = check ? value * 1.8 + 32 : (value - 32)/1.8;
    return ans;
  }

  double kelvinAndCelsius(value, check) {
    double ans = check ? value + 273 : value - 273;
    return ans;
  }

  void ClearAll() {
    text ='0';
    answer = '0';
  }
}