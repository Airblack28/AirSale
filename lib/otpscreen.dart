import 'dart:developer';

import 'package:airsale/constants.dart';
import 'package:airsale/loginscreen.dart';
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
                  margin: const EdgeInsetsDirectional.only(bottom: 40),
                  child: Text(
                    'Insert the 6 Digits Code who have been sent\nby SMS to the phone number ${widget.phoneNumber}.',
                    style: GoogleFonts.poppins(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                  onTap: () async {
                    try{
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text.toString());
                      // Sign the user in (or link) with the credential
                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) => Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context) => LoginScreen(),
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
