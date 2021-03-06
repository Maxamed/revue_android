import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:revue_mobile/MainScreen.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/FavoriteModal.dart';
import 'package:revue_mobile/Service/ServerDetails.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/compound/CompoundDetails.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/messages/MessagingScreen.dart';
import 'package:url_launcher/url_launcher.dart';



class CompoundList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return CompoundListState();
  }

  CompoundList({Key compoundListKey}):super(key: compoundListKey);
}

class CompoundListState extends State<CompoundList>{
  List compoundList = [];
  List<bool> isFavourite = [];
  List amenityList = [];
  String objectID = "";
  ScrollController _scrollController= new ScrollController();
  @override
  void initState() {
    super.initState();
    getCompoundMethod();
  }

  void getCompoundMethod(){
    Webservice.getCompoundRequest(context,compoundList,objectID).then((value) => this.setState(() {

    }));
  }


  void updateCompounds(){
    objectID = (compoundList.last as CompoundModal).id;
    Webservice.getCompoundRequest(context, compoundList, objectID).then((
        value) => this.setState(() {}));
  }




  @override
  Widget build(BuildContext context) {
   return Container(width: double.infinity,
   child:  ListView.builder(
     controller: _scrollController,
     scrollDirection: Axis.vertical,
     itemCount:compoundList.length,
     shrinkWrap: true,
     physics: BouncingScrollPhysics(),
     itemBuilder: (context,index){

       return Padding(
         padding: const EdgeInsets.only(left: 10,right: 10),
         child: compoundCard(context, index),
       );
     },

   ));
  }

  Widget compoundCard(BuildContext context,int index){
    bool favourite =  false;
    if(favouriteIDList.contains((compoundList[index] as CompoundModal).id)){
      favourite = !favourite;
    }
    return  GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>
            CompoundDetails(compoundDetailsKey: GlobalKeys.compoundDetailsKey,compoundID: (compoundList[index] as CompoundModal).id,compound: (compoundList[index] as CompoundModal))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: new Image.network(ServerDetails.get_images+
                              (compoundList[index] as CompoundModal).images[ind],
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        autoplay: false,
                        itemCount: (compoundList[index] as CompoundModal).images.length,
                        pagination: new SwiperPagination(),


                      ),
                    ),
                  ),
                ),
              ),
              Flexible(flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    // assets/images/userLocation.png
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 2,fit: FlexFit.tight,
                          child: Text(
                              (compoundList[index] as CompoundModal).compoundname.toUpperCase(),
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:  ColorClass.darkTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 16.0
                              ),
                              textAlign: TextAlign.left
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                favourite = !favourite;
                                // isFavourite[index] = !isFavourite[index];
                                FavoriteModal favModal = new FavoriteModal();

                                if(favourite == false){
                                  favouriteIDList.remove((compoundList[index] as CompoundModal).id);
                                  favList.remove(compoundList[index] as CompoundModal);
                                  favModal.compoundID =(compoundList[index] as CompoundModal).id;
                                  Webservice.removeFavoriteRequest(context,favModal)
                                      .then((value) => this.setState(() {}));

                                }
                                else{
                                  favouriteIDList.add((compoundList[index] as CompoundModal).id);
                                  favList.add(compoundList[index] as CompoundModal);
                                  favModal.compoundID =   (compoundList[index] as CompoundModal).id;
                                  Webservice.addFavoriteRequest(context,favModal)
                                      .then((value) => this.setState(() {

                                      }));

                                }
                              });

                            },
                            child
                            : favourite == false
                            ? Icon(Icons.favorite_border,color: ColorClass.blueColor,)
                            : Icon(Icons.favorite,color: ColorClass.blueColor))
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4,bottom: 4),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.location_solid,size: 18,),
                          // Image.asset("assets/images/userLocation.png",
                          //   height: 25,width: 25,alignment: Alignment.topLeft,fit: BoxFit.cover,),
                          Text(
                              "ADDRESS : ",
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
                          (compoundList[index] as CompoundModal).address,
                          style:  TextStyle(
                              color:  ColorClass.darkTextColor,
                              fontWeight: FontWeight.w300,
                              fontStyle:  FontStyle.normal,
                              fontSize: 12.0
                          ),

                          textAlign: TextAlign.start
                      ),
                    ),



                  ],),
                ),),
            ],),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Container(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap:(){
print("onTap");

                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: "revueappqa@gmail.com",
                      query: encodeQueryParameters(<String, String>{
                        'subject': (compoundList[index] as CompoundModal).category+" : "+(compoundList[index] as CompoundModal).compoundname
                      }),
                    );

                    launch(emailLaunchUri.toString());
                  } ,
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
                ),
                GestureDetector(behavior: HitTestBehavior.translucent,onTap: (){
                  CompoundModal compound=(compoundList[index] as CompoundModal);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              MessagingScreen(key: GlobalKeys.addQuestionKey,compoundID: compound.id,
                                compoundName:   compound.compoundname,address:  compound.address)));

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

            Divider(color: Color(0x33000000),thickness: 1,)

          ],
        ),
      ),
    );
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}