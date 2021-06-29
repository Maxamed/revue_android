import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revue_mobile/reviews/MyReview/MyReviews.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/ColorClass.dart';
import '../Login.dart';

class MyAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAccountState();
  }
}

class MyAccountState extends State<MyAccount>{
  SharedPreferences sharedPreferences;
  String name;String email;
 Future<dynamic> getSharedPreference()async{
    sharedPreferences =await SharedPreferences.getInstance();
    setState(() {
      name=  sharedPreferences.getString("name");
      email =  sharedPreferences.getString("email");
    });
  }


  @override
  void initState() {
    getSharedPreference().then((value) => this.setState(() {

    }));
   super.initState();

  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            largeTitle:
            Text("My Account", style:  TextStyle(
                    color:  ColorClass.darkTextColor,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 20.0
                ),
                textAlign: TextAlign.left
            ),
            ),

            SliverToBoxAdapter(
              child: Column(mainAxisSize: MainAxisSize.min,children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFAvatar(shape: GFAvatarShape.circle,
                    backgroundColor: Colors.black12,
                    size: 100,
                    foregroundColor: Colors.grey,child: Text(name.substring(0,1).toUpperCase(),
                      style: TextStyle(color: ColorClass.redColor,fontWeight: FontWeight.w700,fontSize: 40),),
                    // backgroundImage: AssetImage("assets/images/person.png"),
                  ),
                ),

                SizedBox(height: 10,),

                Text(name,
                    style: const TextStyle(
                        color:  const Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 22.0
                    ),
                    textAlign: TextAlign.center
                ),
                // thomas.shelby001@gmail.com
                Text(email!=null?email:"",
                    style: const TextStyle(
                        color:  const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontStyle:  FontStyle.normal,
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.center
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Material(
                    child: ListTile(
                      leading: Image.asset("assets/images/inspection.png",width: 20,height: 20,),
                      title:// My Reviews
                      Text(
                          "My Reviews",
                          style: const TextStyle(
                              color:  const Color(0xb2000000),
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 18.0
                          ),
                          textAlign: TextAlign.left
                      ),
                      trailing: Icon(CupertinoIcons.forward,color: Colors.black,),
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>
                        MyReviews()));
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 60,right: 60,bottom: 20,top: 50),
                  child:    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: ColorClass.blueColor,
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: (){
                      googleSignIn.signOut();
                      FacebookAuth.instance.logOut();
                      twitterLogin.logOut();
                      sharedPreferences.clear();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text(
                        "Log out",
                        style: const TextStyle(
                            color:  const Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 20.0
                        ),
                        textAlign: TextAlign.left
                    ),

                  ),
                )


              ],),
            )



          ],
        ),

    );
  }

}