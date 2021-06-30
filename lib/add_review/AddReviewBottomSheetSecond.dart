
import 'dart:io';
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
import 'package:revue_mobile/constant/GlobalKeys.dart';

import 'AddReviewBottomSheetFirst.dart';

final globalKey = GlobalKeys.addReviewSecondKey;

class AddReviewBottomSheetSecond extends StatefulWidget{
  ReviewModal reviewModal;


  AddReviewBottomSheetSecond({Key globalKey,this.reviewModal}):super(key: globalKey);

  @override
  State<StatefulWidget> createState() {
    return AddReviewBottomSheetSecondState();
  }
}

class AddReviewBottomSheetSecondState extends State<AddReviewBottomSheetSecond>{
  List<ProsWidget> textfieldListPros = <ProsWidget>[];
  List<ConsWidget> textfieldListCons = <ConsWidget>[];
  List prosList =[];
  List consList =[];

  // List<String> tempProsList =[];

  @override
  void initState() {
    super.initState();
    textfieldListPros.add(ProsWidget(0));
    textfieldListCons.add(ConsWidget());
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
      height: 300,
      child: GridView.count(
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(pickedImages.length, (index) {
          Asset asset = pickedImages[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: AssetThumb(
              asset: asset,
              width: 500,
              height: 500,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 600,
        child: ListView(
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
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),



                ListView.builder(
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: textfieldListPros.length,
                  itemBuilder: (context, index) {
                    return textfieldListPros[index];
                  },
                ),

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
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),
                // ListView.builder(
                //   shrinkWrap:true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: textfieldListCons.length,
                //   itemBuilder: (context, index) {
                //     return textfieldListCons[index];
                //   },
                // ),

                ListView.builder(
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: textfieldListCons.length,
                  itemBuilder: (context, index) {
                    return textfieldListCons[index];
                  },
                ),
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
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),

                Container(margin: EdgeInsets.all(30),
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
                                  color: const Color(0x4d000000),
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
                    ) :buildGridView())
              ],
            ),
          ),

          Align(alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pop(context);
                    },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back_ios_outlined,color:Colors.black ,),
                        Text(
                            "BACK",
                            style: const TextStyle(
                                color:  const Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 18.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ],
                    ),
                  ),
                ),


                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: textfieldListPros.isNotEmpty
                      &&textfieldListCons.isNotEmpty
                      &&pickedImages.isNotEmpty ?() async{

                    for(int i =0;i<textfieldListPros.length;i++){
                      prosList.add(textfieldListPros[i].prosTextController.text);
                    }

                    print(prosList);
                    for(int i =0;i<textfieldListCons.length;i++){
                      consList.add(textfieldListCons[i].consTextController.text);
                    }

                    List<MultipartFile> tempList =[];

                    for(Asset asset in pickedImages){
                      ByteData byteData = await asset.getByteData();
                      List<int> imageData = byteData.buffer.asInt8List();
                      MultipartFile multipartFile = new MultipartFile.fromBytes( "imageData",
                          imageData,filename:asset.name,);
                    tempList.add(multipartFile);
                    }


                    widget.reviewModal.pros = prosList;
                    widget.reviewModal.cons = consList;
                    widget.reviewModal.images= tempList;

                    print(widget.reviewModal.pros);

                    showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                          topRight:Radius.circular(20), )),
                        builder:(context) => AddReviewBottomSheetThird(widget.reviewModal));

                  }:(){
                    Fluttertoast.showToast(msg: "All Fields must be Filled");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            "NEXT",
                            style: const TextStyle(
                                color:  const Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 18.0
                            ),
                            textAlign: TextAlign.left
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color:Colors.black ,)
                      ],
                    ),
                  ),
                ),
              ],
            ),)

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
}