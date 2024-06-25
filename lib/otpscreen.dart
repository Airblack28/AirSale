import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
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
            top: 50,
            child: Column(
              children: [
                Container(
                  width: width - 40,
                  margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: Text(
                    'Enter the OTP Code',
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,

                  ),
                ),
                Container(
                  width: width - 40,
                  margin: const EdgeInsetsDirectional.only(bottom: 30),
                  padding: const EdgeInsetsDirectional.only(end: 30),
                  child: Text(
                    'This number will be used for communication and personal identification. You will receive an SMS with an 6 Digits code for verification purpose.',
                    style: GoogleFonts.poppins(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: width - 40,
                  margin: const EdgeInsetsDirectional.only(bottom: 10),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(color: const Color(0xFF000000), fontWeight: FontWeight.w500, fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      hintStyle: GoogleFonts.poppins(color: const Color.fromRGBO(0, 0, 0, 0.2), fontSize: 16),
                      hintText: "Phone Number",
                      prefixStyle: GoogleFonts.poppins(color: const Color(0xFF000000), fontWeight: FontWeight.w700, fontSize: 20),
                      prefixText: "+91   ",
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: width - 40,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 18, 1, 66),
                    ),
                    child: Text('OTP Verification',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color:const Color.fromARGB(255, 255, 255, 255)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+91${phoneController.text}",
                      timeout: const Duration(seconds: 120),
                      verificationCompleted: (PhoneAuthCredential credential) async {
                        // ANDROID ONLY!

                        // Sign the user in (or link) with the auto-generated credential
                        await FirebaseAuth.instance.signInWithCredential(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                        }
                      },
                      codeSent: (String verificationId, int? resendToken) async {
                        // Update the UI - wait for the user to enter the SMS code
                        String smsCode = 'xxxx';

                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                        // Sign the user in (or link) with the credential
                        await FirebaseAuth.instance.signInWithCredential(credential);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LoginScreen(),
                  //   )
                  // ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(vertical: 30),
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
