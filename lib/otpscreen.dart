import 'dart:developer';

import 'package:airsale/constants.dart';
import 'package:airsale/loginscreen.dart';
import 'package:airsale/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
  String phoneNumber;
  OtpScreen({super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            child: Image.asset("assets/images/bg_screen.png", fit: BoxFit.fitHeight, height: height)
          ),
          Positioned(
            top: 150,
            child: Column(
              children: [
                //Intro Text
                Container(
                  width: width - 40,
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: Text(
                    "Almost There!",
                    style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: width - 40,
                  child: Text(
                    'Insert the 6 Digits Code who have been sent\nby SMS to the phone number ${widget.phoneNumber}.',
                    style: GoogleFonts.poppins(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Text("If you inserted a Wrong Number, ",
                      style: GoogleFonts.poppins(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(style: BorderStyle.solid, color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.5) : primaryColorDark.withOpacity(0.3))),
                        ),
                        child: Text("Click Here.",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? primaryColorLight.withOpacity(0.5) : primaryColorDark.withOpacity(0.4)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () async {
                        Navigator.pushReplacement(context,
                              MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                          )
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                //Input TextField
                Container(
                  width: width - 40,
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 15),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      hintText: "6 Digits OTP",
                    ),
                  ),
                ),
                //OTP Verification Button
                GestureDetector(
                  child: otpController.text.length != 6 ?
                  Container(
                    width: width - 40,
                    padding: const EdgeInsets.all(20),
                    child: Text('OTP Verification',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  ) : loading ? Container(
                    margin: const EdgeInsetsDirectional.only(start: 20, end: 20), padding: const EdgeInsets.all(20),child: CircularProgressIndicator()
                  ) : Container(
                    width: width - 40,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: MediaQuery.of(context).platformBrightness == Brightness.light ? secondaryColorLight : secondaryColorDark,
                    ),
                    child: Text('OTP Verification',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: loading ? null : () async {
                    setState(() {
                      loading = true;
                    });

                    try{
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text.toString());
                      // Sign the user in (or link) with the credential
                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) => setState(() {loading = false;})).then((value) => Navigator.pushReplacement(context,
                          MaterialPageRoute(
                          builder: (context) => WelcomeScreen(phoneNumber: widget.verificationId),
                        )
                      ));
                    } catch(ex) {
                      log(ex.toString());
                    }
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
