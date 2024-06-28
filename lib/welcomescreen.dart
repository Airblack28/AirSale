import 'package:airsale/constants.dart';
import 'package:airsale/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  String phoneNumber;
  WelcomeScreen({super.key, required this.phoneNumber});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 1),
              //Intro Text
              Text(
                "Hey, Welcome!",
                style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Congrats, Your phone number have been verifed.\nPlease Provider some additionnal informations.',
                style: GoogleFonts.poppins(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              //Phone verified
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.01) : primaryColorDark.withOpacity(0.02),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MediaQuery.of(context).platformBrightness == Brightness.dark ?
                      SvgPicture.asset(
                        "assets/icons/icon_check.svg", color: primaryColorDark.withOpacity(0.1)
                      ) : SvgPicture.asset(
                        "assets/icons/icon_check.svg", color: primaryColorLight.withOpacity(0.1)
                      ),
                    SizedBox(width: 8),
                    Text('Phone Number Verified',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.dark ? primaryColorDark.withOpacity(0.4) : primaryColorLight.withOpacity(0.2)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //Input Name TextField
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    hintText: "Enter your Name",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Input Email TextField
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: TextField(
                  controller: emailController,
                  // onEditingComplete: () {
                  //   if
                  // },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    hintText: "Enter your Email ID",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Input Address TextField
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: TextField(
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    hintText: "Enter your City",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //Save Info Button
              GestureDetector(
                child: nameController.text.isNotEmpty && emailController.text.isNotEmpty && addressController.text.isNotEmpty ?
                loading ? Container(
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20), padding: const EdgeInsets.all(20),child: CircularProgressIndicator()
                ) : Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: MediaQuery.of(context).platformBrightness == Brightness.light ? secondaryColorLight : secondaryColorDark,
                  ),
                  child: Text('Save Information',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                    textAlign: TextAlign.center,
                  ),
                ) : Container(
                  width: double.infinity,
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  padding: const EdgeInsets.all(20),
                  child: Text('Save Information',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: loading ? null : () async {
                  setState(() {
                    loading = true;
                  });
                  final user = FirebaseAuth.instance.currentUser;
                  final data = {
                    // "username": "User001",
                    // "name": nameController.text,
                    // "email": emailController.text,
                    // "address": addressController.text,
                    // "phone": widget.phoneNumber
                    "username": user?.uid,
                    "name": nameController.text,
                    "email": emailController.text,
                    "address": addressController.text,
                    "phone": user?.phoneNumber
                  };
                  user!.updateDisplayName(nameController.text);
                  await Future.delayed(Duration(seconds: 2));
                  FirebaseFirestore db = FirebaseFirestore.instance;
                  await db.collection("users").add(data)
                    .then((documentSnapshot) => print("Added Data with ID: ${documentSnapshot.id}"))
                    .onError((e, _) => print("Error writing document: $e"))
                    .then((value) => setState(() {loading = false;}))
                    .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())));
                },
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
