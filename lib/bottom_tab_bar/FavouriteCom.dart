
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:revue_mobile/MainScreen.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/FavoriteModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/bottom_tab_bar/SearchWidget.dart';
import 'package:revue_mobile/compound/CompoundDetails.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/messages/MessagingScreen.dart';

final favGlobalKey= GlobalKeys.favoriteKey;
class FavouriteCom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return FavouriteComState();
  }

  FavouriteCom({Key favGlobalKey}):super(key: favGlobalKey);

}

List favouriteIDList = [];
class FavouriteComState extends State<FavouriteCom>{


  @override
  void initState() {
    super.initState();
    if(favList.isEmpty){

      Webservice.getAllFavoritesCompoundRequest().whenComplete(() => this.setState(() {

      }));
    }

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          SearchWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 10,right: 10),
            child: ListView(shrinkWrap:true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 5),
                  child: Text(
                      "My Favourite",
                      style:  TextStyle(
                          color:  ColorClass.blueColor,
                          fontWeight: FontWeight.w600,
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ),

                favList.isEmpty?
                Text("No Property added",
                    style: TextStyle(
                        color:  Colors.black,
                        fontStyle:  FontStyle.normal,
                        fontSize:14.0
                    ),
                    textAlign: TextAlign.left
                ):

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: favList.length,shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            CompoundDetails(compoundDetailsKey: GlobalKeys.compoundDetailsKey,
                                compoundID: (favList[index] as CompoundModal).id,
                                compound: (favList[index] as CompoundModal))));

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:  Column(
                          children: [
                            Row(children: [
                              Flexible(
                                flex: 1,
                                child:  Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Container(
                                      width: 200,
                                      height:140,
                                      child:  Swiper(
                                        itemBuilder: (BuildContext context, int ind) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: new Image.network(
                                              (favList[index] as CompoundModal).images[ind],
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                        autoplay: false,
                                        itemCount: (favList[index] as CompoundModal).images.length,
                                        pagination: new SwiperPagination(),


                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    // assets/images/userLocation.png
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(flex: 2,fit: FlexFit.tight,
                                          child: Text(
                                              (favList[index] as CompoundModal).compoundname.toUpperCase(),
                                              maxLines: 2,
                                              style:  TextStyle(
                                                  color:  ColorClass.darkTextColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 16.0

                                              ),
                                              textAlign: TextAlign.left
                                          ),
                                        ),
                                        GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: ()
                                            {
                                              FavoriteModal favModal = new FavoriteModal();
                                              favModal.compoundID =(favList[index] as CompoundModal).id;
                                              Webservice.removeFavoriteRequest(context,favModal)
                                                  .then((value) => this.setState(() {}));
                                              favouriteIDList.remove((favList[index] as CompoundModal).id);
                                              favList.remove(favList[index] as CompoundModal);
                                            },
                                            child:Icon(CupertinoIcons.heart_fill,
                                              color: ColorClass.blueColor,))
                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 4,bottom: 4),child: Row(
                                      children: [
                                        Icon(CupertinoIcons.location_solid,size: 18,),
                                        // Image.asset("assets/images/userLocation.png",
                                        //   height: 25,width: 25,alignment: Alignment.topLeft,fit: BoxFit.cover,),
                                        Text(
                                            "ADDRESS",
                                            style:  TextStyle(
                                                color: Colors.grey.shade800 ,
                                                fontWeight: FontWeight.w400,
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 12.0
                                            ),
                                            textAlign: TextAlign.left
                                        )
                                      ],
                                    ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                          (favList[index] as CompoundModal).address,
                                          style:  TextStyle(
                                              color:  ColorClass.darkTextColor,
                                              fontWeight: FontWeight.w300,
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 12.0
                                          ),
                                          textAlign: TextAlign.start
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                                    //     Image.asset("assets/images/ratingStar.png"),
                                    //     Image.asset("assets/images/ratingStar.png"),
                                    //     Image.asset("assets/images/ratingStar.png"),
                                    //     Image.asset("assets/images/ratingStar.png"),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(left: 3),
                                    //       child: RichText(
                                    //           text: TextSpan(
                                    //               children: [
                                    //                 TextSpan(
                                    //                     style: const TextStyle(
                                    //                         color:  const Color(0xff000000),
                                    //                         fontWeight: FontWeight.w700,
                                    //                         fontStyle:  FontStyle.normal,
                                    //                         fontSize: 15.0
                                    //                     ),
                                    //                     text: "4.8/"),
                                    //                 TextSpan(
                                    //                     style: const TextStyle(
                                    //                         color:  const Color(0x78000000),
                                    //                         fontWeight: FontWeight.w300,
                                    //                         fontStyle:  FontStyle.normal,
                                    //                         fontSize: 15.0
                                    //                     ),
                                    //                     text: "5")
                                    //               ]
                                    //           )
                                    //       ),
                                    //     )
                                    //   ],),
                                    // ),


                                  ],),
                                ),),
                            ],),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                                Container(
                                  child: Row(children: [
                                    Icon(CupertinoIcons.mail_solid,size: 18,color:Colors.blue.shade700),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          "Email",
                                          style:  TextStyle(
                                              color:   ColorClass.darkTextColor,
                                              fontWeight: FontWeight.w400,
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 13.0
                                          ),
                                          textAlign: TextAlign.left
                                      ),
                                    )
                                  ],),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,onTap: (){
                                  CompoundModal compound=(favList[index] as CompoundModal);
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              MessagingScreen(compound.id,
                                                  compound.compoundname, compound.address)));

                                },
                                  child: Container(
                                    child: Row(children: [
                                      Icon(CupertinoIcons.chat_bubble_2_fill,color:Colors.blue.shade700,size: 20,),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            "Q and A",
                                            style:  TextStyle(
                                                color:  ColorClass.darkTextColor,
                                                fontWeight: FontWeight.w400,

                                                fontStyle:  FontStyle.normal,
                                                fontSize: 13.0
                                            ),
                                            textAlign: TextAlign.left
                                        ),
                                      )
                                    ],),
                                  ),
                                ),
                                Container(
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          "View more",
                                          style:  TextStyle(
                                              color:  ColorClass.blueColor,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 12.0
                                          ),
                                          textAlign: TextAlign.left
                                      ),
                                    )
                                  ],),
                                )
                              ],),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            //     Container(
                            //       child: Row(children: [
                            //         Icon(CupertinoIcons.phone_fill),
                            //         Padding(
                            //           padding: const EdgeInsets.all(5.0),
                            //           child: Text(
                            //               "Call",
                            //               style: const TextStyle(
                            //                   color:  const Color(0xff000000),
                            //                   fontWeight: FontWeight.w400,
                            //
                            //                   fontStyle:  FontStyle.normal,
                            //                   fontSize: 13.0
                            //               ),
                            //               textAlign: TextAlign.left
                            //           ),
                            //         )
                            //       ],),
                            //     ),
                            //     Container(
                            //       child: Row(children: [
                            //         Icon(CupertinoIcons.mail_solid),
                            //         Padding(
                            //           padding: const EdgeInsets.all(5.0),
                            //           child: Text(
                            //               "Email",
                            //               style: const TextStyle(
                            //                   color:  const Color(0xff000000),
                            //                   fontWeight: FontWeight.w400,
                            //
                            //                   fontStyle:  FontStyle.normal,
                            //                   fontSize: 13.0
                            //               ),
                            //               textAlign: TextAlign.left
                            //           ),
                            //         )
                            //       ],),
                            //     ),
                            //     Container(
                            //       child: Row(children: [
                            //         Icon(CupertinoIcons.bubble_left_bubble_right_fill),
                            //         Padding(
                            //           padding: const EdgeInsets.all(5.0),
                            //           child: Text(
                            //               "Message",
                            //               style: const TextStyle(
                            //                   color:  const Color(0xff000000),
                            //                   fontWeight: FontWeight.w400,
                            //
                            //                   fontStyle:  FontStyle.normal,
                            //                   fontSize: 13.0
                            //               ),
                            //               textAlign: TextAlign.left
                            //           ),
                            //         )
                            //       ],),
                            //     ),
                            //     Container(
                            //       child: Row(children: [
                            //         Padding(
                            //           padding: const EdgeInsets.all(5.0),
                            //           child: Text(
                            //               "View more",
                            //               style: const TextStyle(
                            //                   color:  const Color(0xff4285f4),
                            //                   fontWeight: FontWeight.w600,
                            //
                            //                   fontStyle:  FontStyle.normal,
                            //                   fontSize: 16.0
                            //               ),
                            //               textAlign: TextAlign.left
                            //           ),
                            //         )
                            //       ],),
                            //     )
                            //   ],),
                            // ),

                            Divider(color: Color(0x33000000),thickness: 1,)

                          ],
                        ),
                      ),
                    );
                  },

                )

              ],),
          ),

        ],
      ),
    );
  }

}
