import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:revue_mobile/Modal/Users.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/password/ForgetPassword.dart';
import 'package:revue_mobile/MainScreen.dart';

import 'SignUp.dart';
//
GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

final TwitterLogin twitterLogin = new TwitterLogin(
  consumerKey: 'nvFi1jcnbxlFLMkf0o9ByIMUM',
  consumerSecret: 'S4lVSuDffbVXaK3FYkw5Sq2RGK9A9p4IqYwvosWEzYib8oJF87',
);

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController  = TextEditingController();
  bool passwordVisible;
  // GoogleSignInAccount _currentUser;


  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  Future<void> _handleGoogleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // GoogleSignInAuthentication googleSignInAuthentication =  await googleSignInAccount.authentication;
    // print(googleSignInAuthentication.accessToken);
    print(googleSignInAccount.displayName);
    print(googleSignInAccount.email);
    print(googleSignInAccount.id);
    print(googleSignInAccount.photoUrl);

    UserModal userModal= new UserModal();
    userModal.email = googleSignInAccount.email;
    userModal.firstName = googleSignInAccount.displayName;

    Webservice.socialMediaLogin(context,googleSignInAccount.email,googleSignInAccount.displayName,false);
  }


  Future<void> _facebookSignIn() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
    print(result.message);
    if (result.status == LoginStatus.success) {
      AccessToken _accessToken = result.accessToken;
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      Map<String,dynamic> _userData = userData;
      print(_userData);

      if(_userData["email"]!=null &&_userData["email"]!=""){
        Webservice.socialMediaLogin(context,_userData["email"],_userData["name"],false);
      }else{
        Fluttertoast.showToast(msg: "No Email is Associated with this Facebook Account");
      }


    } else {
      print(result.status);
      print(result.message);
    }

  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
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

            shrinkWrap: true,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.only(left:90.0,right: 90,top: 80),
                child: Image.asset("assets/images/revueLogo.png"),
              )),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40,right: 40,top: 240),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/input.png")
                    )
                ),
                child: TextField(textInputAction: TextInputAction.next,
                  controller: emailController,keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                        color: Color(0x7f3c2f47),
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white
                  ),),
              )
              , Container(
                height: 50,
                margin: EdgeInsets.only(left: 40,right: 40,top: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/input.png")
                    )
                ),
                child: TextFormField(
                  controller: passwordController,keyboardType: TextInputType.visiblePassword,
                  obscureText: !passwordVisible,
                  validator: (value) => value.isEmpty ?
                  "Please enter password" : null,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all( 15),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        color: Color(0x7f3c2f47),
                        fontSize: 18,

                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    suffixIcon: IconButton(icon:Icon(
                        passwordVisible? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },)
                  ),),
              ),
              Container(
                margin: EdgeInsets.only(left: 40,right: 40,top:15),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgetPassword()));
                  },
                  child: Text(
                      "Forget password?",
                      style: const TextStyle(
                          color:  const Color(0xff4285f4),
                          fontWeight: FontWeight.w600,
                          fontStyle:  FontStyle.normal,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(left:110,right:110,top: 40),

                child:   ElevatedButton(
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Sahitya',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {


                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").
                      hasMatch(emailController.text);
                      if(emailValid==false){
                        Fluttertoast.showToast(msg:"Please Enter Valid Email Address");
                      }
                      else if(passwordController.text.length<6){
                        Fluttertoast.showToast(msg:"Please Enter Valid Password");
                      }
                      else{
                        UserModal userModal = new UserModal();
                        userModal.email = emailController.text;
                        userModal.password = passwordController.text;
                        Webservice.loginRequest(context, userModal);
                      }

                    }else{
                      Fluttertoast.showToast(msg:"Please fill fields");

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
              Container(
                margin: EdgeInsets.only(left: 75,right: 75,top: 25),
                child: Row(mainAxisSize:  MainAxisSize.max ,
                  children: [
                    Expanded(child: Container(color: Colors.black,height: 1,)),
                    Container(margin: EdgeInsets.only(left: 5,right: 5),
                      child: Text('OR',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Container(color: Colors.black,height: 1,)),
                  ],),
              ),
              Container(margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(type: MaterialType.transparency,
                        elevation: 20,
                        child: GestureDetector(
                            onTap: (){
                              _facebookSignIn();
                            },
                            child: Image.asset("assets/images/fb.png",))),
                    Material(type: MaterialType.transparency,
                        elevation: 20,
                        child: GestureDetector(
                          onTap: (){
                            _handleGoogleSignIn();
                          },behavior: HitTestBehavior.translucent,
                          child: Container(margin: EdgeInsets.only(left:40,right: 40),
                              child: Image.asset("assets/images/google.png")),
                        )),
                    Material(type: MaterialType.transparency,
                        elevation: 20,
                        child: GestureDetector(onTap: (){
                          handleTwitterLogin();
                        },
                            child: Image .asset("assets/images/twitter.png")))
                  ],),
              ),
              Container(margin: EdgeInsets.only(top:30,bottom: 30),
                child:   Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                      },
                      child: Text('Sign Up',
                        style: TextStyle(
                          color: Color(0xffea4335),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                  ],),
              )
            ],),
        ],
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //   image: DecorationImage(fit: BoxFit.cover,
    //       image: AssetImage("assets/images/map.png"))
    // ),
    //   child:


    // ),

  }

  void handleTwitterLogin()
  async {


    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        // UserModal userModal= new UserModal();

        // userModal.email = result.session.userId;
        // userModal.firstName = result.session.username;
        Webservice.socialMediaLogin(context, "", result.session.username,true);
        print('Logged in! username: ${result.session.userId}');
        print('Logged in! username: ${result.session.username}');
print(result.session.toMap());
        print('Logged in! username: ${result.session.secret}');
        break;
      case TwitterLoginStatus.cancelledByUser:
      print('Login cancelled by user.');
        break;
      case TwitterLoginStatus.error:
        print('Login error: ${result.errorMessage}');
        break;
    }

  }

}
