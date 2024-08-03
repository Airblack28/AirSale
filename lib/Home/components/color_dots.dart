import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product_colors,
  }) : super(key: key);

  final List<int> product_colors;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            product_colors.length,
            (index) => ColorDot(
              color: Color(product_colors[index]),
              // color: Colors.black,
              isSelected: index == selectedColor,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {},
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.add),
            // showShadow: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? primaryColorLight : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
