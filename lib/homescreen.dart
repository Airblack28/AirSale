import 'package:airsale/constants.dart';
import 'package:airsale/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    double width = MediaQuery.of(context).size.width;
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
                  width: width - 40,
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
                GestureDetector(
                  child: loading ? Container(
                    margin: const EdgeInsetsDirectional.only(start: 20, end: 20), padding: const EdgeInsets.all(20),child: CircularProgressIndicator()
                  ) : Container(
                    width: width - 40,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? secondaryColorLight : secondaryColorDark,
                    ),
                    child: Text('Log Out',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: loading ? null : () async {
                    setState(() {
                      loading = true;
                    });

                    FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())));

                    setState(() {
                      loading = false;
                    });
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
