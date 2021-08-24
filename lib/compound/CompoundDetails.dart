
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/FavoriteModal.dart';
import 'package:revue_mobile/Service/ServerDetails.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetFirst.dart';
import 'package:revue_mobile/add_review/Add_Review.dart';
import 'package:revue_mobile/compound/AmenitiesGridClass.dart';
import 'package:revue_mobile/compound/CompoundRatings.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/constant/custom_dialog.dart';
import 'package:revue_mobile/map/mapScreen.dart';
import 'package:revue_mobile/messages/MessagingScreen.dart';
import 'package:revue_mobile/reviews/reviews_list.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/MainScreen.dart';
import 'package:share/share.dart';


class CompoundDetails extends StatefulWidget {
 final String compoundID;



 // List compoundList = [];
 // List<bool> isFavourite;
 CompoundModal compound;

  CompoundDetails({Key compoundDetailsKey,this.compoundID,this.compound}):super(key: compoundDetailsKey);

  @override
  State<StatefulWidget> createState() {
    return CompoundDetailsState();
  }
}

class CompoundDetailsState extends State<CompoundDetails> {

  ScrollController _scrollController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }
  bool descTextShowFlag = false;

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  List reviewList = [];
  CompoundModal compoundModal;
  bool favourite=false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    getCompoundDetails();


    if(favouriteIDList.contains(widget.compound.id)){
      favourite = !favourite;
    }

  }


  getCompoundDetails()async{
  CompoundModal value = await Webservice.getCompoundDetails(widget.compoundID);
   setState(() {
     compoundModal = value;
   });
  fetchReview();
  }



  fetchReview(){
    Webservice.fetchAllReviews(context,
        widget.compoundID,reviewList).then((value) => this.setState(() {

    }));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoScaffold(
        body: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: new Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 5,
                                primary: ColorClass.redColor,
                                  padding: EdgeInsets.all(10)
                              ),
                              icon: favourite?
                              Icon(
                                CupertinoIcons.suit_heart_fill,
                                color: Colors.white,
                              ):Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                favourite = !favourite;
                                // isFavourite[index] = !isFavourite[index];
                                FavoriteModal favModal = new FavoriteModal();

                                if(favourite == false){
                                  favouriteIDList.remove(widget.compound.id);
                                  favList.remove(widget.compound);
                                  favModal.compoundID =widget.compound.id;
                                  Webservice.removeFavoriteRequest(context,favModal)
                                      .then((value) => this.setState(() {}));

                                }
                                else{
                                  favouriteIDList.add(widget.compound.id);
                                  favList.add(widget.compound);
                                  favModal.compoundID =   widget.compound.id;
                                  Webservice.addFavoriteRequest(context,favModal)
                                      .then((value) => this.setState(() {

                                  }));

                                }
                              },
                              label: Text(
                                "Save",
                                style: TextStyle(fontSize: 16,color: ColorClass.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: ColorClass.redColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 5,padding: EdgeInsets.all(10)
                              ),
                              icon: Icon(
                                CupertinoIcons.location_solid,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        MapPage(compoundModal.position["coordinates"][0],
                                          compoundModal.position["coordinates"][1],)));
                              },
                              label: Text(
                                "Map",
                                style: TextStyle(fontSize: 16,color: ColorClass.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 5,
                              padding: EdgeInsets.all(10),
                                primary: ColorClass.redColor
                              ),
                              icon: Icon(
                                CupertinoIcons.chat_bubble_2_fill,
                                color: Colors.white,
                              ),

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            MessagingScreen(key:GlobalKeys.addQuestionKey,
                                                compoundID: compoundModal.id,
                                                address: compoundModal.address,
                                                compoundName:  compoundModal.compoundname)));
                              },
                              label: Text(
                                "Q and A",
                                style: TextStyle(fontSize: 16,color: ColorClass.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: CustomScrollView(
            controller: _scrollController,


            slivers: [
              SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  primary: true,snap: false,
                  leading: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.chevron_left,
                        color: Colors.black,
                      )),
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {

                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Text(
                          compoundModal.compoundname,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: isShrink ? ColorClass.redColor :Colors.transparent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Stack(
                            clipBehavior: Clip.none,
                          children: [

                            Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return new Image.network(ServerDetails.get_images+
                                  compoundModal.images[index],
                                  fit: BoxFit.fill,
                                );
                              },
                              autoplay: false,
                              itemCount: compoundModal.images.length,
                              pagination: new SwiperPagination(),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: (){
                                  print("on tapped click");
                                  Share.share("Check out this property\n"
                                      "https://revue-app.com/#/home/compoundDetail/${compoundModal.id}");
                                },
                                child: Container(
                                  margin: EdgeInsets
                                  .only(top: 10,bottom: 10,right: 20),
                                  decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.share_outlined,
                                    color: Colors.blue,
                                    size: 20,),
                                  ),),
                              ),
                              // child: InkWell(
                              //   onTap: (){
                              //     Share.share("Check out this property https://revueapp.com/property");
                              //   },
                              //   child: Container(
                              //     margin: EdgeInsets.only(top: 20,left: 8,right: 10),
                              //     decoration: BoxDecoration(color: Colors.white,
                              //     shape: BoxShape.circle),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Icon(
                              //         Icons.share_outlined,
                              //         color: Colors.blue,
                              //         size: 30,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),

                    );
                  })),


              SliverList(delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                compoundModal.compoundname,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: isShrink ?Colors.transparent:ColorClass.redColor,
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                    compoundModal.address,maxLines: 2,
                                    style:  TextStyle(
                                      color: ColorClass.lightTextColor,fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,),
                                    textAlign: TextAlign.left),
                              ),

                            ],
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // GestureDetector(
                                //   onTap: (){
                                //     Share.share("Check out this property https://revueapp.com/property");
                                //   },
                                //   child: Icon(
                                //     Icons.share_outlined,
                                //     color: Colors.blue,
                                //     size: 40,
                                //   ),
                                // ),
                                SizedBox(width: 5,),
                                CircularPercentIndicator(
                                  radius: 40.0,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 4.0,
                                  percent: StringConstant.getpercentage(compoundModal.rating.toDouble()),
                                  center: new Text(
                                    (compoundModal.rating.toDouble()).toStringAsFixed(1),
                                    style:
                                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor: ColorClass.circularBgColor,
                                  progressColor: ColorClass.redColor,
                                  // footer: Padding(
                                  //   padding: const EdgeInsets.all(3.0),
                                  //   child: Text(
                                  //       "${reviewList.length} \nReviews",
                                  //       style:  TextStyle(
                                  //           color:Colors.black ,
                                  //           fontWeight: FontWeight.w500,
                                  //           fontStyle:  FontStyle.normal,
                                  //           fontSize: 12.0
                                  //       ),
                                  //       textAlign: TextAlign.center
                                  //   ),
                                  // ),
                                ),
                                ],),
                          ),
                        )

                      ]),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rating",
                        style:  TextStyle(color: ColorClass.darkTextColor,
                          fontWeight: FontWeight.w600,fontSize: 18,
                          fontStyle: FontStyle.normal,),),
                      SizedBox(height: 20,),
                      CompoundRatings(compoundModal)

                    ],),
                ),


                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amentites",style: TextStyle(color: ColorClass.darkTextColor,
                        fontWeight: FontWeight.w600,fontSize: 18,
                        fontStyle: FontStyle.normal,),
                      ),
                      // SizedBox(height: 10,),
                      AmenitiesGridClass(compoundModal.amenities),
                    ],
                  ),
                ),


                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",style: TextStyle(color: ColorClass.darkTextColor,
                        fontWeight: FontWeight.w600,fontSize: 18,
                        fontStyle: FontStyle.normal,),
                      ),
                      SizedBox(height: 10,),
                      Text(compoundModal.description,
                        maxLines:descTextShowFlag?compoundModal.description.length: 4,
                        overflow: TextOverflow.fade,textAlign: TextAlign.start,
                        style: TextStyle(
                            color: ColorClass.lightTextColor,fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,wordSpacing: 2,letterSpacing: 0.3),),

                      Container(
                          margin: EdgeInsets.only(top: 5,bottom: 20),
                          alignment: Alignment.centerRight,
                          child: descTextShowFlag ? GestureDetector(
                            onTap: (){
                              setState(() {
                                descTextShowFlag = !descTextShowFlag;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("READ LESS",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12,
                                        color: ColorClass.blueColor,fontWeight: FontWeight.w600)),
                                Icon(Icons.keyboard_arrow_up_outlined,color: Colors.black,)
                              ],
                            ),
                          ) :
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                descTextShowFlag = !descTextShowFlag;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("READ MORE",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12,
                                        color: ColorClass.blueColor,fontWeight: FontWeight.w600)),
                                Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,)
                              ],
                            ),
                          ))
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // REviews
                      Text("Reviews",
                          style: TextStyle(
                              color: ColorClass.darkTextColor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                          textAlign: TextAlign.left),
                      ElevatedButton(
                          onPressed: ()
                          async {
                            bool exists= await Webservice.checkReview(compoundModal.id);
                            if(!exists){
                              GlobalKeys.reviewListKey.currentState.openAddReview();
                            }
                            else{
                              displayAlertDialog(context,title: "Add Review",content: "Review Already Exists");

                              // Fluttertoast.showToast(msg: "Review Already Exists");
                            }

                      }, child: Text("Add Review",style: TextStyle(fontSize: 12),)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8),
                  child: Divider(
                    color: ColorClass.greyColor,
                    thickness: 0.5,
                  ),
                ),

                ReviewList(key: GlobalKeys.reviewListKey,reviewList: reviewList,compoundModal:compoundModal)

              ])),
              CupertinoSliverRefreshControl(
                onRefresh:(){
                  return new Future<void>.delayed(const Duration(seconds: 2))
                    ..then((_) {
                      Webservice.getCompoundDetails(widget.compoundID).then((value){
                        this.setState(() {
                          compoundModal = value;
                        });
                      });

                    });

                },
              ),



            ],
          )
        ),
      ),
    );
  }



  // void openBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       )),
  //       isScrollControlled: true,
  //       builder: (context) => AddReviewBottomSheetFirst(compoundModal.id,compoundModal.compoundname));
  //   //         (BuildContext context,ScrollController controller){
  //   //   return ;
  //   // });
  // }
}
