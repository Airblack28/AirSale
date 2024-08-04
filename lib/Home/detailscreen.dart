import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
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
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int Quantity = 1;
  int maxLines = 3;
  String seeMoreOrLess = "See More Details";
  IconData iconArrow = Icons.keyboard_arrow_down;
  bool isAdded = false;
  double progress = 2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light ? Color(0xFFF5F6F9) : bgcolorDarkTheme,
      appBar: CustomAppBar(rating: 4.0, isFavourite: widget.isFavourite),
      body: ListView(
      children: [
        ProductImages(tag: widget.tag, product_images: widget.product_images, product_colors: widget.product_colors),
        RoundedContainer(
          color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10,
          padding: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              //Product Title
              Text(widget.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              //Product Description
              Text(widget.description, style: TextStyle(fontSize: 12), maxLines: maxLines),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (maxLines == 3) {
                      maxLines = 15;
                      seeMoreOrLess = "See Less Details";
                      iconArrow = Icons.keyboard_arrow_up;
                    } else {
                      maxLines = 3;
                      seeMoreOrLess = "See More Details";
                      iconArrow = Icons.keyboard_arrow_down;
                    }
                  });
                },
                child: Row(
                  children: [
                    Text(seeMoreOrLess, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    )),
                    Icon(iconArrow, size: 15,
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        RoundedContainer(
          color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10,
          padding: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity: " + "$Quantity unit(s)"),
              Row(
                children: [
                  IconButton(onPressed: () {
                    setState(() {
                      Quantity = Quantity + 1;
                    });
                  }, icon: Icon(Icons.add)),
                  IconButton(onPressed: () {
                    setState(() {
                      if (Quantity > 1) {
                        Quantity = Quantity - 1;
                      }
                    });
                  }, icon: Icon(Icons.remove)),
                ],
              ),
            ],
          ),
        ),
        // Price Bar
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorDarkTheme : bgcolorLightTheme,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                width: isAdded ? width : 0,
                height: 80,
                curve: Curves.bounceIn,
                duration: Duration(milliseconds: 2000),
                onEnd: () {},
                decoration: BoxDecoration(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme.withOpacity(0.2): bgcolorDarkTheme.withOpacity(0.2),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.price * Quantity} USD' , style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold,
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorLight,
                      letterSpacing: -1,
                    )),
                    isAdded ? Row(
                      children: [
                        Text(
                          "Let's Gooo",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorLight,
                            letterSpacing: -1,
                          ),
                        ),
                        SizedBox(width: 0),
                        LottieBuilder.asset(
                          "assets/animations/adding_animation.json",
                          width: 36,
                          height: 36,
                          repeat: false,
                        ),
                      ],
                    ) : GestureDetector(
                      onTap: () {
                        setState(() { isAdded = true;});
                        Future.delayed(Duration(seconds: 3))
                        .then((value) => setState(() {isAdded = false;}))
                        .then((value) => setState(() {Quantity = 1;}));
                      },
                      child: Row(
                        children: [
                          Text("Add To Cart", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600,
                            color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorLight,
                            letterSpacing: -1,
                          )),
                          SizedBox(width: 10),
                          SvgPicture.asset("assets/icons/bag.svg", height: 23,
                            color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  CustomAppBar({required this.rating, required this.isFavourite,})
      : super(preferredSize: Size.fromHeight(AppBar().preferredSize.height), child: AppBar());
  final double rating;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(
                  MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10
                )),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset("assets/icons/Back ICon.svg", height: 15,
                  color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight : primaryColorDark,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text("$rating",style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(
                  MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10
                )),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Heart Icon_2.svg", height: 15, color: isFavourite ? Colors.red : Color(0xFFDBDEE4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.tag,
    required this.product_images,
    required this.product_colors,
  }) : super(key: key);
  final String tag;
  final List<String> product_images;
  final List<int> product_colors;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}
class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 240,
          height: 340,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.tag,
              // child: Image.network(widget.product_images[selectedImage]),
              child: Image.asset(widget.product_images[selectedImage]),
            ),
          ),
        ),
        Container(
          width: width,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(widget.product_images.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(right: 10, top: 0, bottom: 0),
                        padding: EdgeInsets.all(8),
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: selectedImage == index ?
                            MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10
                            : MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white38 : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // child: Image.network(widget.product_images[index]),
                        child: Image.asset(widget.product_images[index]),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(widget.product_colors.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(left: 5, top: 0, bottom: 0),
                        padding: EdgeInsets.all(10),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: selectedColor == index ?
                            MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.white10
                            : MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white38 : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(widget.product_colors[index]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.color,
    required this.padding,
    required this.child,
  }) : super(key: key);

  final Color color;
  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: EdgeInsets.only(top: padding, bottom: padding, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: child,
    );
  }
}