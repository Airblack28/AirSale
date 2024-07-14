import 'package:airsale/constants.dart';
import 'package:airsale/Home/homescreen.dart';
import 'package:airsale/Welcome/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IconButton(
                  icon: Icon(Icons.close,size: 40,),
                  onPressed: () {Navigator.of(context).pop();},
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  "${DateFormat("EEE").format(today)} ${DateFormat("d MMMM").format(today)}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                ),
                subtitle: Text(
                  "Hello ${FirebaseAuth.instance.currentUser?.displayName}",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: MediaQuery.of(context).platformBrightness == Brightness.light ? errorColor : errorColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.mark_unread_chat_alt_sharp, size: 14,
                           color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorDark),
                          SizedBox(width: 3),
                          Text("3 Notifs",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12,
                           color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorDark : primaryColorDark)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.verified_sharp, size: 20),
                        SizedBox(width: 2),
                        Text("Verified",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              for (int i = 0; i < menuItem.length; i++)
                Column(
                  children: <Widget>[
                    for (int j = 0; j < menuItem[i].length; j++)
                      GestureDetector(
                        onTap: () { Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) => menuItem[i][j].link,
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: MediaQuery.of(context).platformBrightness != Brightness.dark ? primaryColorLight : primaryColorDark,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              menuItem[i][j].icon,
                              size: 35,
                              color: MediaQuery.of(context).platformBrightness != Brightness.dark ? primaryColorDark : primaryColorLight,
                            ),
                          ),
                          title: Text(
                            menuItem[i][j].name,
                            style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            menuItem[i][j].instruction,
                            style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    SizedBox(height: 30),
                  ],
                ),
              GestureDetector(
                onTap: () async {
                    // FirebaseAuth.instance.currentUser?.updateDisplayName(null);
                    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())));
                  },
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: MediaQuery.of(context).platformBrightness != Brightness.dark ? primaryColorLight : primaryColorDark,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.logout,size: 35,
                      color: MediaQuery.of(context).platformBrightness != Brightness.dark ? primaryColorDark : primaryColorLight,
                    ),
                  ),
                  title: Text(
                    "Log Out",
                    style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Disconnect your account",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItems {
  final dynamic link;
  final String name, instruction;
  final IconData icon;

  MenuItems(
      {required this.link,
      required this.icon,
      required this.name,
      required this.instruction});
}

final menuItem = [
  [
    MenuItems(
      link: HomeScreen(),
      // icon: Icons.maps_home_work_sharp,
      icon: Icons.business_center,
      name: "Home",
      instruction: "Look all the Products",
    ),
    MenuItems(
      link: HomeScreen(),
      icon: Icons.widgets,
      name: "Products",
      instruction: "Look all the Products",
    ),
    MenuItems(
      link: HomeScreen(),
      icon: Icons.favorite,
      name: "Favourites",
      instruction: "Look all the commande",
    ),
    MenuItems(
      link: HomeScreen(),
      icon: Icons.monetization_on,
      name: "Cart",
      instruction: "For selected products",
    ),
  ],
  [
    MenuItems(
      link:HomeScreen(),
      icon: Icons.poll_rounded,
      name: "History",
      instruction: "For previous purchases",
    ),
    MenuItems(
      link: HomeScreen(),
      icon: Icons.settings_suggest_rounded,
      name: "Profile",
      instruction: "For managing your account",
    ),
    MenuItems(
      link: HomeScreen(),
      icon: Icons.my_location_outlined,
      name: "About Us",
      instruction: "For more informations",
    ),
  ],
];
