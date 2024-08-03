import 'package:flutter/material.dart';
import 'components/color_dots.dart';
import 'components/custom_app_bar.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailScreen extends StatelessWidget {
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
  final String price;
  final String description;
  final String image;
  final List<String> product_images;
  final List<int> product_colors;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    final _quantityController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: 4.0),
      body: ListView(
      children: [
        ProductImages(tag: tag, product_images: product_images),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(name: name, description: description, isFavourite: isFavourite, pressOnSeeMore: () {}),
              TopRoundedContainer(
                color: Color.fromRGBO(201, 55, 15, 1),
                child: Column(
                  children: [
                    ColorDots(product_colors: product_colors),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.15,
                          right: width * 0.15,
                          bottom: 40,
                          top: 15,
                        ),
                        child: TextButton(
                          child: Text("Add to Card"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text("Quantity"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: _quantityController,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Done"),
                                    onPressed: () async {
                                      if(_quantityController.text.isEmpty && _quantityController.text == ""){
                                        if (int.parse(_quantityController.text) > 0){
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  )
                                ],
                              )
                            );
                          },
                        ),
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