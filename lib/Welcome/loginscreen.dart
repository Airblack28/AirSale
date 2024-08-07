import 'package:airsale/constants.dart';
import 'package:airsale/Welcome/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
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
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: Text(
                    'Ready To Start?',
                    style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 40),
                  child: Text(
                    'This number will be used for communication\nand personal identification. You will receive a\nSMS with 6 Digits Code for verification purpose.',
                    style: GoogleFonts.poppins(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Input TextField
                Container(
                  width: width,
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      hintText: "Phone Number",
                      prefixIcon: SizedBox(
                        width: 70,
                        child: Text('  +91',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                ),
                //Get OTP Button
                GestureDetector(
                  child: phoneController.text.length != 10 ?
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(20),
                    child: Text('Get an OTP Code',
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
                    child: Text('Get an OTP Code',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: MediaQuery.of(context).platformBrightness == Brightness.light ? bgcolorLightTheme : bgcolorDarkTheme),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: loading ? null : () async {
                    setState(() {
                      loading = true;
                    });
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+91${phoneController.text.toString()}",
                      timeout: const Duration(seconds: 120),
                      verificationCompleted: (PhoneAuthCredential credential) async {},
                      verificationFailed: (FirebaseAuthException e) {},
                      forceResendingToken: 2,
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      codeSent: (String verificationId, int? resendToken) async {
                        setState(() {loading = true;});
                        // Navigate to the OTP Page for verification
                        Navigator.pushReplacement(context,MaterialPageRoute(
                          builder: (context) => OtpScreen(verificationId: verificationId, phoneNumber: "+91${phoneController.text.toString()}"),
                        ));
                        setState(() {loading = false;});
                      },
                    );
                  },
                ),
                //Use Google Account
                // Container(
                //   width: width - 40,
                //   margin: const EdgeInsetsDirectional.symmetric(vertical: 30),
                //   child: Text(
                //     'Use an existant account',
                //     style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                //Term and Condition Text
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(vertical: 50),
                  child: Text(
                    'By registering you agree to our \nTerms of Use and Privacy Policy',
                    style: GoogleFonts.poppins(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
    }
}
