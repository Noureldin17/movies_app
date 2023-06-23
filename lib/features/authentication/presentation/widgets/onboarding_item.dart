import 'package:flutter/src/widgets/framework.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.item});
  final Widget item;
  @override
  Widget build(BuildContext context) {
    return item;
  }
}
