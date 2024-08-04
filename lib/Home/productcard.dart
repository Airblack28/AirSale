import 'package:airsale/Home/detailscreen.dart';
import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.tag,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.product_images,
    required this.product_colors,
    required this.isFavourite,
  }) : super(key: key);

  final String tag;
  final String name;
  final int price;
  final String description;
  final String image;
  final List<String> product_images;
  final List<int> product_colors;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MediaQuery.of(context).platformBrightness ==
          Brightness.light
          ? primaryColorLight.withOpacity(0.05)
          : primaryColorDark.withOpacity(0.05),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
            DetailScreen(
              tag: tag,
              name: name,
              description: description,
              price: price,
              image: image,
              product_images: product_images,
              product_colors: product_colors,
              isFavourite: isFavourite)
            )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.01,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Hero(
                  tag: tag,
                  child: Image.asset(image),
                ),
              ),
            ),
            Text(name,
              // maxLines: 2,
              style: TextStyle(
                fontSize: 13,
                // color: MediaQuery.of(context).platformBrightness == Brightness.dark ? primaryColorLight:primaryColorDark,
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$price USD',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // color: MediaQuery.of(context).platformBrightness == Brightness.dark ? primaryColorLight : primaryColorDark
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 33,
                    width: 33,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: Color(0xFFDBDEE4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
