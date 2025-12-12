import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/colors.dart';

class ScrollingDots extends StatelessWidget {
  const ScrollingDots({super.key, required this.index, required this.count, this.color});
  final int count;
  final int index;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 8,
        child: AnimatedSmoothIndicator(
          activeIndex: index,
          count: count,
          axisDirection: Axis.horizontal,
          effect: ExpandingDotsEffect(
            spacing: 8,
            activeDotColor: color ?? AppColors.primary,
            dotColor: AppColors.darkerGrey,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ),
    );
  }
}
