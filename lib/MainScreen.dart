import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/bottom_tab_bar/home/HomePage.dart';
import 'package:revue_mobile/bottom_tab_bar/MyAccount.dart';
import 'package:revue_mobile/bottom_tab_bar/home/HomePage.dart';

import 'constant/ColorClass.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

List favList = [];
class MainScreenState extends State<MainScreen>{
  int currentIndex = 0;
  bool selected = false;
  Color selectedColor = ColorClass.blueColor;
  void _onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  List <Widget> _screensList = [HomePage(),FavouriteCom(),MyAccount()];


  @override
  void initState() {
    super.initState();
    Webservice.getAllFavoritesCompoundRequest().then((value) => this.setState(() {

    }));
  }

  @override
  Widget build(BuildContext context) {
   // return SafeArea(
   //   child: CupertinoTabScaffold(
   //     resizeToAvoidBottomInset: true,
   //     tabBar: CupertinoTabBar(
   //       backgroundColor:Colors.white,
   //       activeColor: ColorClass.redColor,
   //       inactiveColor: ColorClass.inactiveIconColor,
   //       currentIndex: currentIndex,
   //
   //       // onTap: (index){
   //       //   currentIndex = index;
   //       //   if(currentIndex ==0){
   //       //     // return FirstPage();
   //       //   }else if(currentIndex==1){
   //       //   }else if(currentIndex ==2){
   //       //   }
   //       // },
   //       items: [
   //         BottomNavigationBarItem(
   //           icon: Icon(CupertinoIcons.search,),title: Text(
   //             "Search",
   //             style: const TextStyle(
   //                 fontWeight: FontWeight.w600,
   //                 fontStyle:  FontStyle.normal,
   //                 fontSize: 12.0
   //             ),
   //         )
   //         ),
   //         BottomNavigationBarItem(
   //             icon: Icon(CupertinoIcons.heart,),title: Text(
   //             "Favourite",
   //             style: const TextStyle(
   //                 fontWeight: FontWeight.w600,
   //                 fontStyle:  FontStyle.normal,
   //                 fontSize: 12.0
   //             ),
   //
   //         ),
   //         ),
   //         BottomNavigationBarItem(
   //             icon: Icon(CupertinoIcons.person,),title: Text(
   //             "My Account",
   //             style: const TextStyle(
   //                 fontWeight: FontWeight.w600,
   //                 fontStyle:  FontStyle.normal,
   //                 fontSize: 12.0
   //             ),
   //         )
   //         ),
   //       ],
   //     ),
   //     tabBuilder: (context, index){
   //       switch (index) {
   //         case 0:
   //           return HomePage();
   //          break;
   //         case 1:
   //           return FavouriteCom();
   //           break;
   //         case 2:return MyAccount();
   //           break;
   //         default:return HomePage();
   //           break;
   //       }
   //     },
   //
   //
   //
   //
   //   ),
   // );


    return Container(color: Colors.white,
      child: SafeArea(bottom: false,
          child: Scaffold(
        body: _screensList[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 17,color: ColorClass.blueColor),
          selectedIconTheme: IconThemeData(color: ColorClass.redColor),
          unselectedIconTheme: IconThemeData(color: ColorClass.inactiveIconColor),
          unselectedLabelStyle: TextStyle(fontSize: 15,color: ColorClass.inactiveIconColor),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon:  Icon(CupertinoIcons.search,), label: "Search",),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart,), label: "Favorite"),
            BottomNavigationBarItem(icon:  Icon(CupertinoIcons.person,), label: "My Account"),
          ],
        ),
      )),
    );
  }
}