import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:revue_mobile/Service/Webservice.dart';

import '../constant/ColorClass.dart';

class ChangePassword extends StatefulWidget{
  String email;

  ChangePassword(this.email);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangePasswordState();
  }
}
class ChangePasswordState extends State<ChangePassword>{
  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  void _toggle() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _togglePassword(){
    setState(() {
      _obscureConfirmPasswordText=!_obscureConfirmPasswordText;
    });
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: SafeArea(
          child: Material(
            child: Container(
            width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/mapbg.png"),fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.white, BlendMode.softLight),
      )
      ),child:
            CustomScrollView(slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor: Colors.white,
                leading:
                GestureDetector(
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
                        fontWeight: FontWeight.w600,

                        fontStyle: FontStyle.normal,
                        fontSize: 22.0),
                    textAlign: TextAlign.left),
              ),
              SliverToBoxAdapter(child: Column(children: [
// Set New password
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
// First Name
                      Text(
                          "Set New Password",
                          style: const TextStyle(
                              color:  Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 18.0
                          ),
                          textAlign: TextAlign.left
                      ),
                      TextField(textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        obscureText: _obscurePasswordText,
                        controller: newPasswordController,
                        decoration: InputDecoration(
                            suffixIcon:
                            IconButton(icon:
                            _obscurePasswordText?
                            Icon(
                              Icons.visibility_off,color: ColorClass.blueColor,):
                            Icon(
                              Icons.visibility,color: ColorClass.blueColor,),
                              onPressed: (){
                                _toggle();
                              },),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  ColorClass.greyColor,),
                            ),
                            fillColor: Colors.white
                        ),),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
// First Name
                      Text(
                          "Confirm Password",

                          style: const TextStyle(
                              color:  Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 18.0
                          ),
                          textAlign: TextAlign.left
                      ),
                      TextField(textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: confirmPasswordController,
                        obscureText: _obscureConfirmPasswordText,
                        decoration: InputDecoration(
                            suffixIcon:
                            IconButton(icon:
                            _obscureConfirmPasswordText?
                            Icon(
                              Icons.visibility_off,color: ColorClass.blueColor,):
                            Icon(
                              Icons.visibility,color: ColorClass.blueColor,),
                              onPressed: (){_togglePassword();},
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorClass.greyColor,),
                            ),
                            fillColor: Colors.white
                        ),),
                    ],
                  ),
                ),


                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 70,bottom: 30),
                  height: 50
                  ,child: SizedBox(
                  width: 300,height: 50,
                  child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: ColorClass.blueColor,  padding: EdgeInsets.all(10),
                    ),
                    onPressed: (){
                      if(newPasswordController.text.length<6||confirmPasswordController.text.length<6){
                        Fluttertoast.showToast(msg: "Password length must be more than 6 characters");
                      }
                      if(newPasswordController.text==confirmPasswordController.text){
                        Webservice.changePasswordRequest(context, confirmPasswordController.text, widget.email);
                      }else{
                        Fluttertoast.showToast(msg: "Password doesnot match");
                      }

                    },
                    child: Text("Done",style: TextStyle(fontSize: 16,color: Colors.white,),),

                  ),
                ),
                ),

              ],),)
            ],) ,),
          )
      ),
    );
  }
}

