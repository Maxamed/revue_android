import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';
import 'Modal/Users.dart';
import 'Service/Webservice.dart';
import 'constant/ColorClass.dart';


class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return SignUpState();
  }

}

class SignUpState extends State<SignUp>{
  TextEditingController emailController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.fill,
                      image: AssetImage("assets/images/map.png"))
              ),
          ),
          ListView(
            children: [
              // Create Account
              Padding(
                padding: const EdgeInsets.only(top: 40,left: 20,bottom: 40),
                child: Text(
                    "Create Account",
                    style:  TextStyle(
                        color: ColorClass.blueColor,
                        fontWeight: FontWeight.w700,
                        fontStyle:  FontStyle.normal,
                        fontSize: 30.0
                    ),
                    textAlign: TextAlign.left
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Name
                          Text(
                              "First Name",
                              style:  TextStyle(
                                  color:  ColorClass.blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 18.0
                              ),
                              textAlign: TextAlign.left
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            child: TextField(
                              controller: firstNameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: ColorClass.blackColor,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15),

                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color:  ColorClass.greyColor,),
                                  ),
                                  fillColor: Colors.white
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Name
                          Text(
                              "Last Name",
                              style:  TextStyle(
                                  color:ColorClass.blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 18.0
                              ),
                              textAlign: TextAlign.start
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            child: TextField(
                              controller: lastNameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: ColorClass.blackColor,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color:  ColorClass.greyColor,),
                                  ),
                                  fillColor: Colors.white
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Text(
                        "Email Address",
                        style:  TextStyle(
                            color: ColorClass.blueColor,
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                    TextField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: ColorClass.blackColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  ColorClass.greyColor,),
                          ),
                          fillColor: Colors.white
                      ),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Text(
                        "Mobile No.",
                        style:  TextStyle(
                            color:ColorClass.blueColor,
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                    TextField(
                      controller: mobileNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: ColorClass.blackColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  ColorClass.greyColor,),
                          ),
                          fillColor: Colors.white
                      ),),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Text(
                        "Password",
                        style:  TextStyle(
                            color:  ColorClass.blueColor,
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                    TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        color: ColorClass.blackColor,
                        fontSize: 16,
                      ),
                      validator: (value) => value.isEmpty ? "Please enter password" : null,

                      decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  ColorClass.greyColor,),
                          ),
                          fillColor: Colors.white
                      ),),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Text(
                        "Confirm Password",
                        style:  TextStyle(
                            color: ColorClass.blueColor,
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                    TextFormField(textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        color: ColorClass.blackColor,
                        fontSize: 16,
                      ),
                      validator: (value) => value.isEmpty ? "Confirm password is required" : null,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  ColorClass.greyColor,),
                          ),
                          fillColor: Colors.white
                      ),),
                  ],
                ),
              ),

              Container(margin: EdgeInsets.only(left:80,right:80,top: 50),
                alignment: Alignment.center,

                child:   ElevatedButton(
                  child: Text('Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Sahitya',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {

                    if(emailController.text.isNotEmpty
                        &&passwordController.text.isNotEmpty
                        &&firstNameController.text.isNotEmpty
                    &&mobileNumberController.text.isNotEmpty){

                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
                      if(emailValid==false){
                        Fluttertoast.showToast(msg: "Enter Valid Email");
                      }else if(passwordController.text.length<6 ){
                        Fluttertoast.showToast(msg: "Enter Valid Password");
                      }else if(passwordController.text!=confirmPasswordController.text){
                        Fluttertoast.showToast(msg: "Enter Same Password");
                      }else if(mobileNumberController.text.length<6&&mobileNumberController.text.length>15){
                        Fluttertoast.showToast(msg: "Enter Valid Mobile Number");
                      }
                      else{
                        UserModal userModal = new UserModal();
                        userModal.email = emailController.text;
                        userModal.password = passwordController.text;
                        userModal.firstName = firstNameController.text;
                        userModal.lastName = lastNameController.text;
                        userModal.mobileNumber = mobileNumberController.text.toString();
                        Webservice.registerRequest(context,userModal);
                      }
                    }else{
                      Fluttertoast.showToast(msg:"All Fields Are Required");
                    }
                    },
                  style: ElevatedButton.styleFrom(
                    primary: ColorClass.blueColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),


              SizedBox(height: 120,),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                        },
                        child: Text('Sign In',
                          style: TextStyle(
                            color: Color(0xffea4335),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                    ],),
                ],
              ),
              SizedBox(height: 60,),
            ],),
        ],
      ),
    ),
  );
  }
}
