import 'package:airsale/Home/productCard.dart';
import 'package:airsale/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:airsale/Home/menuscreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animations/animations.dart';

class Productsscreen extends StatefulWidget {
  Productsscreen({super.key});

  @override
  State<Productsscreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Productsscreen> {
  final user = FirebaseAuth.instance.currentUser;
  reloadUser() {
    user?.reload();
  }

  bool loading = false;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 90,
        actions: <Widget>[
          Container(
          width: width - 170,
          height: 60,
          margin: EdgeInsets.only(left: 20, right: 5),
          child: TextField(
          decoration: InputDecoration(
            hintText: "Search a Product ...",
            prefixIcon: Icon(Icons.search)),
          ),
        ),
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: primaryColorLight,
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.asset("assets/icons/bag.svg", color: primaryColorDark),
          ),
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            transitionDuration: const Duration(milliseconds: 500),
            openColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
            openBuilder: (context, _) { return MenuScreen();},
            closedColor: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme,
            closedElevation: 0,
            closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            closedBuilder: (context, VoidCallback openContainer) {
              return Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: primaryColorLight,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.menu, size: 30, color: primaryColorDark),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  width: width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      //Categories
                      SizedBox(width: 20),
                      RoundedContainer(
                        color: primaryColorLight.withOpacity(0.2),
                        child: Text("All"),
                      ),
                      RoundedContainer(
                        color: primaryColorLight.withOpacity(0.02),
                        child: Text("Electronics"),
                      ),
                      RoundedContainer(
                        color: primaryColorLight.withOpacity(0.02),
                        child: Text("Fashion"),
                      ),
                      RoundedContainer(
                        color: primaryColorLight.withOpacity(0.02),
                        child: Text("Braids and Wigs"),
                      ),
                      RoundedContainer(
                        color: primaryColorLight.withOpacity(0.02),
                        child: Text("Home Cleaning"),
                      ),
                      SizedBox(width: 10),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            width: width,
            height: height - 190,
            top: 70,
            child: Container(
              width: width,
              height: 620,
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: StreamBuilder(
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
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Cast the data to a Map<String, dynamic>
                      Map<String, dynamic> doc = documents[index].data() as Map<String, dynamic>;
                      // Access fields using bracket notation safely
                      String tag = doc['tag'] ?? ''; // Provide a default value if 'tag' is null
                      String name = doc['name'] ?? ''; // Provide a default value if 'name' is null
                      int price = doc['price'] ?? 0; // Provide a default value if 'price' is null
                      String description = doc['description'] ?? 'Empty'; // Provide a default value if 'description' is null
                      bool isFavourite = doc['isFavourite'] ?? false; // Provide a default value if 'isFavourite' is null
                      String image = doc['image'] ?? ''; // Provide a default value if 'image' is null
                      List<String> product_images = (doc['product_images'] as List<dynamic>? ?? []).map((item) => item.toString()).toList(); // Provide a default value if 'images' is null
                      List<int> product_colors = (doc['product_colors'] as List<dynamic>? ?? []).map((item) => int.parse(item)).toList(); // Provide a default value if 'colors' is null
                      // Return all the product cards with their fetched data
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: child,
    );
  }
}