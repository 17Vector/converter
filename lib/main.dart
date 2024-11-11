import 'package:flutter/material.dart';
import 'section1.dart';
import 'section2.dart';
import 'section3.dart';
import 'section4.dart';
import 'section5.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Color.fromRGBO(51, 51, 51, 1.0),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 65),
          child: Text(
            'Converter',
            style: TextStyle(
                fontSize: 60,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMainButtonRow(context, 'Масса', Section1Screen()),
          _buildMainButtonRow(context, 'Длина', Section2Screen()),
          _buildMainButtonRow(context, 'Время', Section3Screen()),
          _buildMainButtonRow(context, 'Температура', Section4Screen()),
          _buildMainButtonRow(context, 'Валюта', Section5Screen()),
        ],
      ),
    );
  }


  Widget _buildMainButtonRow(BuildContext context, String label, Widget section) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMainButton(context,label, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => section),
          );
        }),
      ],
    );
  }

  Widget _buildMainButton(BuildContext context, String label, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        width: 350,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(218, 119, 14, 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 45,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

List<String> weightArr = <String>['t', 'kg', 'g', 'lb', 'oz'];
List<String> lengthArr = <String>['mm', 'cm', 'm', 'km', 'mi'];
List<String> currencyArr = <String>['USD', 'EUR', 'GBP', 'RUB', 'CNY'];
List<String> timeArr = <String>['s', 'min', 'h', 'd', 'wk'];
List<String> tempArr = <String>['C', 'F', 'K'];
