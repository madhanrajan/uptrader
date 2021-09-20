import 'package:flutter/material.dart';
import 'package:uptrader/login/login_view.dart';

class AddPredictionView extends StatelessWidget {
  AddPredictionView({required this.backgroundColor});

  final Color backgroundColor;

  final tickerController = TextEditingController();
  final priceController = TextEditingController();

  Widget tickerField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
            controller: tickerController,
            decoration: InputDecoration(hintText: "Ticker symbol")));
  }

  Widget triggerDateField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text("Date"),
          Spacer(),
          TextButton(onPressed: () {}, child: Text("Choose a Date")),
        ],
      ),
    );
  }

  Widget priceField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
            controller: priceController,
            decoration: InputDecoration(hintText: "Predicted Price")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Add your prediction"),
        ),
        body: Container(
            child: Column(
          children: [
            SizedBox(height: 10),
            tickerField(),
            triggerDateField(),
            priceField(),
            ElevatedButton(onPressed: () {}, child: Text("Add Prediction"))
          ],
        )));
  }
}
