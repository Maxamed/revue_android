import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/Service/Webservice.dart';

import '../password/ChangePassword.dart';
import '../constant/ColorClass.dart';

class OTPVerification extends StatefulWidget{
  String email;

  OTPVerification(this.email);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OTPVerificationState();
  }
}

class OTPVerificationState extends State<OTPVerification>{
  TextEditingController firstController= TextEditingController();
  TextEditingController secondController= TextEditingController();
  TextEditingController thirdController= TextEditingController();
  TextEditingController forthController= TextEditingController();
  TextEditingController fifthController= TextEditingController();
  TextEditingController sixthController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/mapbg.png"),fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.white, BlendMode.softLight),
            )
        ),
        child:CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    color: Colors.black,
                  )),
              largeTitle: Text(" Forget Password",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 25.0),
                  textAlign: TextAlign.left),

            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  SizedBox(height: 40,),
                  // Enter OTP
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Enter OTP",
                        style:  TextStyle(
                            color: ColorClass.darkTextColor,
                            fontWeight: FontWeight.w600,

                            fontStyle:  FontStyle.normal,
                            fontSize: 23.0
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 8,right: 8,bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                        width: 45,
                        height: 43,
                        alignment:Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)
                            ),
                            border: Border.all(
                                color: const Color(0x4d000000),
                                width: 1
                            ),
                            color: const Color(0xb2ffffff)
                        ),
                            child: CupertinoTextField(
                              showCursor: false,controller: firstController,
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,

                              ),
                             placeholderStyle:TextStyle(
                                  color:  ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,

                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide.none,
                                    bottom: BorderSide.none,
                                     left: BorderSide.none,
                                    right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                          Container(
                            width: 45,
                            height: 43,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                    color: const Color(0x4d000000),
                                    width: 1
                                ),
                                color: const Color(0xb2ffffff)
                            ),
                            child: CupertinoTextField(
                              textAlign: TextAlign.center,controller: secondController,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              placeholderStyle:TextStyle(
                                  color:  ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                      right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                          Container(
                            width: 45,
                            height: 43,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                    color: const Color(0x4d000000),
                                    width: 1
                                ),
                                color: const Color(0xb2ffffff)
                            ),
                            child: CupertinoTextField(
                              textAlign: TextAlign.center,controller: thirdController,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              placeholderStyle:TextStyle(
                                  color:  ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                      right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                          Container(
                            width: 45,
                            height: 43,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                    color: const Color(0x4d000000),
                                    width: 1
                                ),
                                color: const Color(0xb2ffffff)
                            ),
                            child: CupertinoTextField(
                              textAlign: TextAlign.center,controller: forthController,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              placeholderStyle:TextStyle(
                                  color:  ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                      right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                          Container(
                            width: 45,
                            height: 43,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                    color: const Color(0x4d000000),
                                    width: 1
                                ),
                                color: const Color(0xb2ffffff)
                            ),
                            child: CupertinoTextField(
                              textAlign: TextAlign.center,controller: fifthController,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              placeholderStyle:TextStyle(
                                  color: ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                      right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                          Container(
                            width: 45,
                            height: 43,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                    color: const Color(0x4d000000),
                                    width: 1
                                ),
                                color: const Color(0xb2ffffff)
                            ),
                            child: CupertinoTextField(
                              textAlign: TextAlign.center,controller: sixthController,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              placeholderStyle:TextStyle(
                                  color:  ColorClass.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                      right: BorderSide.none
                                  )
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Align(alignment: Alignment.centerRight,child: Text("Resend Password",style: TextStyle(color: ColorClass.darkTextColor,
                      fontWeight: FontWeight.w600),),),

                  SizedBox(height: 10,),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 60,bottom: 30),
                    height: 50
                    ,child: SizedBox(
                    width: 300,height: 50,
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),primary: ColorClass.blueColor, padding: EdgeInsets.all(10),
                    ),
                      onPressed: (){
                      String otp = firstController.text+secondController.text+thirdController.text+forthController.text+fifthController.text+sixthController.text;

                      Webservice.validateOtpRequest(context,widget.email,otp);
                      },
                      child: Text("Submit",style: TextStyle(fontSize: 16,color:  Colors.white),),

                    ),
                  ),
                  ),
                ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}