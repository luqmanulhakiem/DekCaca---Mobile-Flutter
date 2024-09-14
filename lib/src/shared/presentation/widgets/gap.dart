import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  final double gap;
  const Gap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
      height: gap,
    );
  }
}
