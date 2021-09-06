import 'package:flutter/material.dart';

class WaitGenerateMca extends StatelessWidget {
  const WaitGenerateMca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/2.png'),
            ),
            CircularProgressIndicator(),
            Text('Generating quiz…', style: TextStyle(fontSize: 24)),
            Text(
                'Please wait as we try to generate a quiz based on your article. This might take a while…',
                style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}
