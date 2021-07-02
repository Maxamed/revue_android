
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetThird.dart';
import 'package:revue_mobile/add_review/widgets/cons_widget.dart';
import 'package:revue_mobile/add_review/widgets/pros_widget.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

import 'AddReviewBottomSheetFirst.dart';


class AddReviewBottomSheetSecond extends StatefulWidget{
  // ReviewModal reviewModal;


  AddReviewBottomSheetSecond({Key globalKey}):super(key: globalKey);

  @override
  State<StatefulWidget> createState() {
    return AddReviewBottomSheetSecondState();
  }
}

class AddReviewBottomSheetSecondState extends State<AddReviewBottomSheetSecond>{
  // List<ProsWidget> textfieldListPros = <ProsWidget>[];
  // List<ConsWidget> textfieldListCons = <ConsWidget>[];
  // List prosList =[];
  // List consList =[];

  // List<String> tempProsList =[];

  List<String> consList = [null];
  List<String> prosList = [null];


  @override
  void initState() {
    super.initState();

    // textfieldListPros.add(ProsWidget(0));
    // textfieldListCons.add(ConsWidget());
  }

  List<Asset> pickedImages = <Asset>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: pickedImages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          // actionBarColor: "#F8F9F9",
          //   statusBarColor: "#F8F9F9",
          actionBarTitle: "Revue",
          allViewTitle: "All Photos",
          useDetailsView: false,autoCloseOnSelectionLimit: true,
          // selectCircleStrokeColor: "#000000",
          // actionBarTitleColor: "#000000",

        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      pickedImages = resultList;
      // _error = error;
    });
  }

  Widget buildGridView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(shrinkWrap: true,
        itemCount:pickedImages.length>4?pickedImages.length:pickedImages.length+1 ,
        physics: NeverScrollableScrollPhysics(),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {

          if(index==(pickedImages.length)){

            if(pickedImages.length>4)
              {
                return Container();
              }
                  return Container(
                    width:100,
                    height: 53,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                        border: Border.all(
                            color: ColorClass.greyColor,
                            width: 1
                        ),
                        color: const Color(0x33dadada)
                    ),
                    child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          loadAssets();
                        },
                        child: Image.asset("assets/images/addCamera.png",
                          width: 15,height: 15,)),
                  );
                }
          Asset asset = pickedImages[index];
                return Stack(
                  children: [


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AssetThumb(
                        asset: asset,
                        width: 500,
                        height: 500,
                      ),
                    ),
                    Positioned(right: 0,top:0,
                        child: GestureDetector(onTap: (){
                          pickedImages.remove(asset);
                          setState(() {

                          });
                        },
                            child: Icon(CupertinoIcons.clear_circled_solid,size: 15,))),
                  ],
                );
      },)

      // GridView.count(
      //   crossAxisCount: 3,
      //   physics: NeverScrollableScrollPhysics(),
      //   children: List.generate(
      //       (pickedImages.length), (index) {
      //
      //     if(index>(pickedImages.length)){
      //       return Icon(Icons.ac_unit);
      //     }
      //     else{
      //
      //       Asset asset = pickedImages[index];
      //       return Padding(
      //         padding: const EdgeInsets.all(4.0),
      //         child: AssetThumb(
      //           asset: asset,
      //           width: 500,
      //           height: 500,
      //         ),
      //       );
      //     }
      //
      //   }),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: ListView(physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
                Text(
                    "Pros",
                    style: TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                    ),
                    textAlign: TextAlign.left
                ),
                ..._getProsWidget(),

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
                    "Cons",
                    style:  TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                    ),
                    textAlign: TextAlign.left
                ),

                ..._getConsWidget()

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
                    "Upload Images",
                    style: const TextStyle(
                        color:  Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                    ),
                    textAlign: TextAlign.left
                ),

                Container(margin: EdgeInsets.only(left:30,right:30,top:30,bottom: 20),
                    child:  pickedImages.isEmpty
                        ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:// Rectangle 54
                        Container(
                          width:MediaQuery.of(context).size.width,
                          height: 133,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)
                              ),
                              border: Border.all(
                                  color: ColorClass.greyColor,
                                  width: 1
                              ),
                              color: const Color(0x33dadada)
                          ),
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                loadAssets();
                              },
                              child: Image.asset("assets/images/addCamera.png",
                                width: 15,height: 15,)),
                        )
                    ) :buildGridView()),

              ],
            ),
          ),

          // Align(alignment: Alignment.bottomRight,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       GestureDetector(
          //         behavior: HitTestBehavior.translucent,
          //         onTap: (){
          //           Navigator.pop(context);
          //           },
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Icon(Icons.arrow_back_ios_outlined,color:Colors.black ,),
          //               Text(
          //                   "BACK",
          //                   style:  TextStyle(
          //                       color:  ColorClass.darkTextColor,
          //                       fontWeight: FontWeight.w600,
          //                       fontStyle:  FontStyle.normal,
          //                       fontSize: 18.0
          //                   ),
          //                   textAlign: TextAlign.left
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //
          //
          //       GestureDetector(
          //         behavior: HitTestBehavior.translucent,
          //         onTap: prosList.isNotEmpty
          //             &&consList.isNotEmpty
          //             &&pickedImages.isNotEmpty ?() async{
          //
          //           List tempProList = [];
          //           List tempConsList =[];
          //
          //           for(int i =0;i<prosList.length;i++){
          //             tempProList.add(prosList[i]);
          //           }
          //
          //           print(tempProList);
          //
          //           for(int i =0;i<consList.length;i++){
          //             tempConsList.add(consList[i]);
          //           }
          //
          //           List<MultipartFile> tempList =[];
          //
          //           for(Asset asset in pickedImages){
          //             ByteData byteData = await asset.getByteData();
          //             List<int> imageData = byteData.buffer.asInt8List();
          //             MultipartFile multipartFile = new MultipartFile.fromBytes( "imageData",
          //                 imageData,filename:asset.name,);
          //           tempList.add(multipartFile);
          //           }

          //
          //           widget.reviewModal.pros = tempProList;
          //           widget.reviewModal.cons = tempConsList;
          //           widget.reviewModal.images= tempList;
          //
          //           print(widget.reviewModal.pros);
          //
          //           showModalBottomSheet(context: context,
          //               isScrollControlled: true,
          //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
          //                 topRight:Radius.circular(20), )),
          //               builder:(context) => AddReviewBottomSheetThird(widget.reviewModal));
          //
          //         }:(){
          //           Fluttertoast.showToast(msg: "All Fields must be Filled");
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Text(
          //                   "NEXT",
          //                   style: TextStyle(
          //                       color:  ColorClass.darkTextColor,
          //                       fontWeight: FontWeight.w600,
          //                       fontStyle:  FontStyle.normal,
          //                       fontSize: 18.0
          //                   ),
          //                   textAlign: TextAlign.left
          //               ),
          //               Icon(Icons.arrow_forward_ios_outlined,color:Colors.black ,)
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),)

        ],),
      ),
    );

  }

  Future<File> getImageFileFromAssets(String path) async {
    final file = File(path);
    print(file.path);
    print(file.absolute);
    return file;
  }



  ////////////////////////////////



  List<Widget> _getProsWidget(){
    List<Widget> proTextFieldList = [];
    for(int i=0; i<prosList.length; i++){
      proTextFieldList.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: ProsTextFields(i)),
                SizedBox(width: 14,),
                // we need add button at last friends row
                _addRemoveProButton(i == prosList.length-1, i),
              ],
            ),
          )
      );
    }
    return proTextFieldList;
  }

  //////////////////////////////////

  List<Widget> _getConsWidget(){
    List<Widget> consTextFieldList = [];
    for(int i=0; i<consList.length; i++){
      consTextFieldList.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: ConsTextFields(i)),
                SizedBox(width: 14,),
                // we need add button at last friends row
                _addRemoveConsButton(i == consList.length-1, i),
              ],
            ),
          )
      );
    }
    return consTextFieldList;
  }



  Widget _addRemoveProButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          prosList.insert(0, null);
        }
        else prosList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        // decoration: BoxDecoration(
        //   color: (add) ? ColorClass.blackColor : ColorClass.blueColor,
        // ),
        child: Icon((add) ?
        Icons.add_circle_outline : Icons.remove_circle_outline, color: Colors.black,size: 18,),
      ),
    );
  }
  Widget _addRemoveConsButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          consList.insert(0, null);
        }
        else consList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        // decoration: BoxDecoration(
        //   color: (add) ? ColorClass.blackColor : ColorClass.blueColor,
        // ),
        child: Icon((add) ?
        Icons.add_circle_outline : Icons.remove_circle_outline, color: Colors.black,size: 18,),
      ),
    );
  }

bool validate()
{
 return prosList.isNotEmpty
              &&consList.isNotEmpty
              &&pickedImages.isNotEmpty;
}


Future<void> addToReview(ReviewModal reviewModal) async{
  List tempProList = [];
  List tempConsList =[];

  for(int i =0;i<prosList.length;i++){
    tempProList.add(prosList[i]);
  }

  print(tempProList);

  for(int i =0;i<consList.length;i++){
    tempConsList.add(consList[i]);
  }
  print(tempConsList);

  List<MultipartFile> tempList =[];

  for(Asset asset in pickedImages){
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asInt8List();
    MultipartFile multipartFile = new MultipartFile.fromBytes( "imageData",
      imageData,filename:asset.name,);
    tempList.add(multipartFile);
  }

            reviewModal.pros = tempProList;
           reviewModal.cons = tempConsList;

           print(reviewModal.pros);
           print(reviewModal.cons);
           reviewModal.multipartImages= tempList;

}



}