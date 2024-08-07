import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int? numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        width: 218,
        height: 90,
        child: GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  // fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        MediaQuery.of(context).platformBrightness == Brightness.dark ? Color.fromARGB(255, 16, 16, 16).withOpacity(0.95) : Color(0xFF343434).withOpacity(0.70),
                        MediaQuery.of(context).platformBrightness == Brightness.dark ? Color.fromARGB(255, 16, 16, 16).withOpacity(0.40) : Color(0xFF343434).withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // ignore: unnecessary_null_comparison
                        numOfBrands != null
                            ? TextSpan(text: "$numOfBrands Brands")
                            : TextSpan(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
