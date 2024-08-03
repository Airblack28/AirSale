import 'package:airsale/Home/productCard.dart';
import 'package:airsale/Home/categoryCard.dart';
import 'package:airsale/Home/promotionCard.dart';
import 'package:airsale/Home/searchscreen.dart';
import 'package:airsale/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:airsale/Home/menuscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  reloadUser() {
    user?.reload();
  }

  bool loading = false;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        leading: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          transitionDuration: const Duration(milliseconds: 500),
          openColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
          openBuilder: (context, _) { return MenuScreen();},
          closedColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
          closedElevation: 0,
          closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          closedBuilder: (context, VoidCallback openContainer) { 
            return IconButton(
              icon: Icon(Icons.menu, size: 25),
              onPressed: openContainer,
            );
          },
        ),
        actions: <Widget>[
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            transitionDuration: const Duration(milliseconds: 200),
            openColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
            openBuilder: (context, _) { return SearchScreen();},
            closedColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
            closedElevation: 0,
            closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            closedBuilder: (context, VoidCallback openContainer) { return IconButton(icon: Icon(Icons.search, size: 25), onPressed: openContainer);},
          ),
          SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? bgcolorDarkTheme
                      : bgcolorLightTheme,
            ),
            child: Row(
              children: [
                Text("35.0",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? bgcolorLightTheme
                            : bgcolorDarkTheme)),
                Icon(Icons.monetization_on,
                    size: 20,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? bgcolorLightTheme
                        : bgcolorDarkTheme),
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Positioned(
          child: Column(
            children: [
              //Discount Banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(text: "AirSale.cm\n",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                      TextSpan(text: "Let's Enjoy our new offer\n"),
                    ],
                  ),
                ),
              ),

              // Our Best Promotion
              Container(
                width: width,
                // padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    //Promotion
                    SizedBox(width: 20),
                    PromotionCard(
                      image: "assets/images/promotion-img-01.png",
                      promotion: "45% Discount",
                      numOfBrands: "Let's Enjoy our new offer\nOn all Fashions Products\n\n",
                      press: () {},
                    ),
                    SizedBox(width: 20),
                    PromotionCard(
                      image: "assets/images/promotion-img-02.png",
                      promotion: "Buy 1 Get 1",
                      numOfBrands: "Let's Enjoy our new offer\nOn all House Products\n\n",
                      press: () {},
                    ),
                    SizedBox(width: 20),
                    PromotionCard(
                      image: "assets/images/promotion-img-05.png",
                      promotion: "Buy 1 Get 1\nFree Braids",
                      numOfBrands: "Let's Enjoy our new offer\n",
                      press: () {},
                    ),
                    SizedBox(width: 20),
                    PromotionCard(
                      image: "assets/images/promotion-img-03.png",
                      promotion: "20% Discount\nOn Electronics",
                      numOfBrands: "From March To July 2025\n",
                      press: () {},
                    ),
                    SizedBox(width: 20),
                    PromotionCard(
                      image: "assets/images/promotion-img-04.png",
                      promotion: "35% Discount\nIphone 11 Pro",
                      numOfBrands: "From March To July 2025\n",
                      press: () {},
                    ),
                    SizedBox(width: 20),
                  ]),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(1) : primaryColorDark.withOpacity(1)
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.2) : primaryColorDark.withOpacity(0.2)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Our Best Categories
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Our Best Categories",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text("See More"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: width,
                // padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    //Categories
                    SizedBox(width: 20),
                    CategoryCard(
                      image: "assets/images/category-img-01.png",
                      category: "Electronics",
                      numOfBrands: 18,
                      press: () {},
                    ),
                    CategoryCard(
                      image: "assets/images/category-img-04.png",
                      category: "Fashion",
                      numOfBrands: 24,
                      press: () {},
                    ),
                    CategoryCard(
                      image: "assets/images/category-img-03.png",
                      category: "Braids and Wigs",
                      numOfBrands: 24,
                      press: () {},
                    ),
                    CategoryCard(
                      image: "assets/images/category-img-02.png",
                      category: "Home Cleaning",
                      numOfBrands: 24,
                      press: () {},
                    ),
                    SizedBox(width: 20),
                  ]),
                ),
              ),

              // Popular products
              SizedBox(height: 25),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text("See More"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    SizedBox(width: 20),
                    //One Time Reads - Firestore Fetching Products Data (Method 1)
                    // FutureBuilder<QuerySnapshot>(
                    //   future: FirebaseFirestore.instance.collection('products').get(),
                    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //     if (snapshot.hasError) {
                    //       return Center(child: Text("Unable to Load Data.\nSomething went wrong."));
                    //     }
                    //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    //       return Center(child: Text('No data found'));
                    //     }
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       List<DocumentSnapshot> documents = snapshot.data!.docs;
                    //       return Container(
                    //         width: ((width / 2.5) + 10) * documents.length,
                    //         height: 200,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: documents.length,
                    //           itemBuilder: (context, index) {
                    //             // Cast the data to a Map<String, dynamic>
                    //             Map<String, dynamic> doc = documents[index].data() as Map<String, dynamic>;
                    //             // Access fields using bracket notation safely
                    //             String tag = doc['tag'] ?? ''; // Provide a default value if 'tag' is null
                    //             String name = doc['name'] ?? ''; // Provide a default value if 'name' is null
                    //             String price = doc['price'] ?? '# USD'; // Provide a default value if 'price' is null
                    //             String image = doc['image'] ?? ''; // Provide a default value if 'image' is null
                    //             // Return all the product card with their fetch data
                    //             return ProductCard(
                    //               tag: tag,
                    //               name: name,
                    //               price: price,
                    //               image: image,
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     }
                    //     return Text("Loading Data");
                    //   },
                    // ),

                    // Real Time Updates - Firestore Fetching Products Data (Method 2)
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('products').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No data found'));
                        }
                        // Process the data
                        List<DocumentSnapshot> documents = snapshot.data!.docs;
                        return Container(
                          width: ((width / 2.5) + 10) * documents.length + 1,
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              // Cast the data to a Map<String, dynamic>
                              Map<String, dynamic> doc = documents[index].data() as Map<String, dynamic>;
                              // Access fields using bracket notation safely
                              String tag = doc['tag'] ?? ''; // Provide a default value if 'tag' is null
                              String name = doc['name'] ?? ''; // Provide a default value if 'name' is null
                              String price = doc['price'] ?? '# USD'; // Provide a default value if 'price' is null
                              String description = doc['description'] ?? 'Empty'; // Provide a default value if 'description' is null
                              bool isFavourite = doc['isFavourite'] ?? false; // Provide a default value if 'isFavourite' is null
                              String image = doc['image'] ?? ''; // Provide a default value if 'image' is null
                              List<String> product_images = (doc['product_images'] as List<dynamic>? ?? []).map((item) => item.toString()).toList(); // Provide a default value if 'images' is null
                              List<int> product_colors = (doc['product_colors'] as List<dynamic>? ?? []).map((item) => int.parse(item)).toList(); // Provide a default value if 'colors' is null
                              // Return all the product card with their fetch data
                              return ProductCard(
                                tag: tag,
                                name: name,
                                price: price,
                                description: description,
                                image: image,
                                product_images: product_images,
                                product_colors: product_colors,
                                isFavourite: isFavourite,
                              );
                            },
                          ),
                        );
                      },
                    ),

                    // Sample Data
                    // ProductCard(tag: "Products1", name: "PS4 Controller", price: "100 USD", image: "assets/images/product-img-01.png"),
                    // ProductCard(tag: "Products2", name: "Nike Zoom IV", price: "120 USD", image: "assets/images/product-img-02.png"),
                    // ProductCard(tag: "Products3", name: "Sony HeadSet", price: "180 USD", image: "assets/images/product-img-03.png"),
                    // ProductCard(tag: "Products4", name: "Addidas Tshirt", price: "25 USD", image: "assets/images/product-img-04.png"),
                    // ProductCard(tag: "Products5", name: "Riding Gloves", price: "40 USD", image: "assets/images/product-img-05.png"),
                    // ProductCard(tag: "Products6", name: "Jordan Short", price: "15 USD", image: "assets/images/product-img-06.png"),
                    // ProductCard(tag: "Products7", name: "Blonde Wig", price: "150 USD", image: "assets/images/product-img-07.png"),
                    // ProductCard(tag: "Products8", name: "Tshirt Varsity", price: "30 USD", image: "assets/images/product-img-08.png"),
                    SizedBox(width: 10),
                  ]),
                ),
              ),

              //Term and Condition Text
              // Container(
              //   margin: const EdgeInsetsDirectional.symmetric(vertical: 50),
              //   child: Text(
              //     'By registering you agreed to our \nTerms of Use and Privacy Policy',
              //     style: GoogleFonts.poppins(fontSize: 10),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              //Log out Button
              // OpenContainer(
              //   transitionType: ContainerTransitionType.fade,
              //   transitionDuration: const Duration(milliseconds: 500),
              //   openColor: MediaQuery.of(context).platformBrightness ==
              //           Brightness.light
              //       ? bgcolorLightTheme
              //       : bgcolorDarkTheme,
              //   openBuilder: (context, _) {
              //     return MenuScreen();
              //   },
              //   closedColor: MediaQuery.of(context).platformBrightness ==
              //           Brightness.light
              //       ? bgcolorLightTheme
              //       : bgcolorDarkTheme,
              //   closedElevation: 0,
              //   closedShape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //   closedBuilder: (context, VoidCallback openContainer) {
              //     return GestureDetector(
              //       onTap: openContainer,
              //       child: Container(
              //         padding: const EdgeInsets.all(20),
              //         color: MediaQuery.of(context).platformBrightness ==
              //                 Brightness.light
              //             ? secondaryColorLight
              //             : secondaryColorDark,
              //         child: Text(
              //           'Menu',
              //           style: GoogleFonts.poppins(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600,
              //               color: MediaQuery.of(context).platformBrightness ==
              //                       Brightness.light
              //                   ? bgcolorLightTheme
              //                   : bgcolorDarkTheme),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
