import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';

class CancelTextIconButton extends StatelessWidget {
  const CancelTextIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.close,
        color: kRedColor,
      ),
      label: Text(
        'Cancel',
        style: TextStyle(
          color: kRedColor,
        ),
      ),
    );
  }
}
