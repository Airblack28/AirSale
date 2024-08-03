import 'package:airsale/constants.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.tag,
    required this.product_images,
  }) : super(key: key);

  final String tag;
  final List<String> product_images;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 240,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.tag,
              // child: Image.network(widget.product_images[selectedImage]),
              child: Image.asset(widget.product_images[selectedImage]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product_images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: primaryColorLight.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        // child: Image.network(widget.product_images[index]),
        child: Image.asset(widget.product_images[index]),
      ),
    );
  }
}
