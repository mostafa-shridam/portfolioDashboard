import 'package:flutter/material.dart';

import '../theme/style.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        strokeCap: StrokeCap.square,
        backgroundColor: primaryColor,
        color: Colors.white,
      ),
    );
  }
}
