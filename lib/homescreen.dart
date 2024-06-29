import 'package:airsale/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:airsale/Home/menuscreen.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: 150,
            child: Column(
              children: [
                //Intro Text
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: Text(
                    'Congratulations\n${user?.displayName}',
                    style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1),
                    textAlign: TextAlign.center,
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
