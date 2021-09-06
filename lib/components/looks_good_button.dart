import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';

class LooksGoodButton extends StatelessWidget {
  const LooksGoodButton({
    Key? key,
    required this.destination,
  }) : super(key: key);
  final String destination;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, destination),
      style: ElevatedButton.styleFrom(
        primary: kTealColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Looks Good!'),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
