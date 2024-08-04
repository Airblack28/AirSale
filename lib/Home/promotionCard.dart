import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({
    Key? key,
    required this.promotion,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String promotion, image;
  final String numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // width: width,
      // padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: Container(
          width: width - 40,
          // width: width,
          // padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MediaQuery.of(context).platformBrightness == Brightness.dark ? Color.fromARGB(255, 16, 16, 16).withOpacity(0.95) : Color(0xFF343434).withOpacity(0.75),
                      MediaQuery.of(context).platformBrightness == Brightness.dark ? Color.fromARGB(255, 16, 16, 16).withOpacity(0.30) : Color(0xFF343434).withOpacity(0.05),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$promotion\n",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          // ignore: unnecessary_null_comparison
                          numOfBrands != null
                              ? TextSpan(text: numOfBrands)
                              : TextSpan(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MediaQuery.of(context).platformBrightness == Brightness.dark ? primaryColorLight : primaryColorDark
                      ),
                      child: Text(
                        'Explore Now',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
