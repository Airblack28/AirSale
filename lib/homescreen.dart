import 'package:airsale/Home/productcard.dart';
import 'package:airsale/constants.dart';
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
  reloadUser(){user?.reload();}
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
        leading: IconButton(
          icon: Icon(Icons.menu, size: 25),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 25),
              onPressed: () {}
            ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorDarkTheme : bgcolorLightTheme,
              ),
              child: Row(
                children: [
                  Text("35.0",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme)),
                  Icon(Icons.monetization_on,size: 20, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                ],
              ),
            ),
          SizedBox(width: 20),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: 150,
            child: Column(
              children: [
                //Home Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          // color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          // controller: searchController.value,
                          // onChanged: (value) => searchController.notifyListeners(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Recherche Produit",
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      // ValueListenableBuilder(
                      //   valueListenable: demoCarts,
                      //   builder:(BuildContext context, List<Cart> Cart, Widget){
                      //   return IconBtnWithCounter(
                      //     svgSrc: "assets/icons/Cart Icon.svg",
                      //     numOfitem: Cart.length,
                      //     press: () => Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) {
                      //           return Panier();
                      //         },
                      //       ),
                      //     ),
                      //   );
                      //   }
                      // ),
                      // IconBtnWithCounter(
                      //   svgSrc: "assets/icons/Bell.svg",
                      //   press: () {},
                      // ),
                    ],
                  ),
                ),
                
                // Discount Banner
                Container(
                  height: 120,
                  width: width - 40,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: AssetImage("assets/images/picture2.png"), fit: BoxFit.cover),
                    ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(text: "Come and Enjoy our new offer\n"),
                        TextSpan(text: "All our products",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                
                // Popular products
                SizedBox(height: 20),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Popular Products", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.w600)),
                      Text("See More"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Products
                      ProductCard(),
                      ProductCard(),
                      ProductCard(),
                    ]
                  ),
                ),

                //Term and Condition Text
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(vertical: 50),
                  child: Text(
                    'By registering you agreed to our \nTerms of Use and Privacy Policy',
                    style: GoogleFonts.poppins(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Log out Button
                OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  transitionDuration: const Duration(milliseconds: 500),
                  openColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
                  openBuilder: (context, _) {
                    return MenuScreen();
                  },
                  closedColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
                  closedElevation: 0,
                  closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  closedBuilder: (context, VoidCallback openContainer) {
                    return GestureDetector(
                      onTap: openContainer,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: MediaQuery.of(context).platformBrightness == Brightness.light ? secondaryColorLight : secondaryColorDark,
                        child: Text('Menu',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ]
      ),
    );
    }
}
