import 'package:airsale/constants.dart';
import 'package:airsale/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: SizedBox(
          width: width / 2.5,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? primaryColorLight.withOpacity(0.05)
                          : primaryColorDark.withOpacity(0.95),
                    ),
                    child: Hero(
                      tag: "Products",
                      child: Image.asset(
                          "assets/images/Image Popular Product 1.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text("Wireless Device", maxLines: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "100 USD",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // color: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          // color: kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color: Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}

class ProductItems {
  final dynamic link;
  final String name, instruction;
  final IconData icon;

  ProductItems(
      {required this.link,
      required this.icon,
      required this.name,
      required this.instruction});
}

final ProductItem = [
  [
    ProductItems(
      link: HomeScreen(),
      // icon: Icons.maps_home_work_sharp,
      icon: Icons.business_center,
      name: "Home",
      instruction: "Look all the Products",
    ),
    ProductItems(
      link: HomeScreen(),
      icon: Icons.widgets,
      name: "Products",
      instruction: "Look all the Products",
    ),
    ProductItems(
      link: HomeScreen(),
      icon: Icons.favorite,
      name: "Favourites",
      instruction: "Look all the commande",
    ),
    ProductItems(
      link: HomeScreen(),
      icon: Icons.monetization_on,
      name: "Cart",
      instruction: "For selected products",
    ),
  ],
];
