import 'package:flutter/material.dart';

class AddUsernameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(),
            Center(
                child: ElevatedButton(
              child: Text("Choose"),
              onPressed: () {},
            ))
          ],
        ),
      ),
    );
  }
}
