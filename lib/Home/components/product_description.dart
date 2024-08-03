import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.name,
    required this.description,
    required this.isFavourite,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final String name;
  final String description;
  final bool isFavourite;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            name,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(15),
            width: 64,
            decoration: BoxDecoration(
              color: isFavourite
                  ? primaryColorLight.withOpacity(0.1)
                  : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color: isFavourite ? primaryColorLight : Color(0xFFDBDEE4),
              height: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            description,
            maxLines: 3,
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: 20,
        //     right: 64,
        //   ),
        //   child: FutureBuilder<DocumentSnapshot>(
        //                     future: FirebaseFirestore.instance
        //                               .collection('users')
        //                               .doc(product.author)
        //                               .get(),
        //                     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        //                       if (snapshot.hasData && !snapshot.data!.exists) {
        //                         return Text("No Author");
        //                       }
        //                       if (snapshot.connectionState == ConnectionState.done) {
        //                         return Text(
        //                               "Author: " + snapshot.data!["Username"],
        //                               //snapshot.data!['Username'],
        //                               maxLines: 3,
        //                             );
        //       }
        //       return Text("...");
        //     },
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: primaryColorLight),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: primaryColorLight,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
