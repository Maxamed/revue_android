import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

// class ProsWidget extends StatefulWidget{
//   TextEditingController prosTextController = new TextEditingController();
//   int index;
//
//   ProsWidget(this.index);
//
//   @override
//   State<StatefulWidget> createState() {
//     return ProsWidgetState();
//      }
// }
//
// class ProsWidgetState extends State<ProsWidget>{
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(width:MediaQuery.of(context).size.width,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width:MediaQuery.of(context).size.width-100,
//                   child: TextFormField(textInputAction: TextInputAction.done,
//                     keyboardType: TextInputType.text,
//                     controller: widget.prosTextController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 15),
//                         labelStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color:  ColorClass.greyColor,),
//                         ),
//                         fillColor: Colors.white,
//                     )),
//                 ),
//                 widget.index>0? IconButton(onPressed: (){
//                   globalKey.currentState.textfieldListPros.remove(widget.index--);
//                   globalKey.currentState.setState(() {
//
//                   });
//                 },
//                     icon: Icon(Icons.remove_circle_outline,color: ColorClass.blackColor,size: 20,)):
//                     Container()
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: TextButton.icon(onPressed: (){
//               globalKey.currentState.textfieldListPros.add(ProsWidget(widget.index++));
//               globalKey.currentState.setState(() {
//
//               });
//
//             }, icon: Icon(Icons.add), label: Text("Add More",
//               style: TextStyle(color: ColorClass.blueColor,fontSize: 15),)),
//           ),
//
//           // GestureDetector(
//           //     behavior: HitTestBehavior.translucent,
//           //     onTap: (){
//           //      globalKey.currentState.textfieldListPros.add(ProsWidget());
//           //      globalKey.currentState.setState(() {
//           //
//           //      });
//           //     },
//           //     child: Container(alignment: Alignment.centerRight,child: Text("+ Add More",
//           //       style: TextStyle(color: ColorClass.blueColor,fontSize: 20),)))
//         ],
//       ),
//     );
//   }
// }





class ProsTextFields extends StatefulWidget {
  final int index;
  ProsTextFields(this.index);
  @override
  _ProsTextFieldsState createState() => _ProsTextFieldsState();
}

class _ProsTextFieldsState extends State<ProsTextFields> {
  TextEditingController _proController;

  @override
  void initState() {
    super.initState();
    _proController = TextEditingController();
  }

  @override
  void dispose() {
    _proController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _proController.text = GlobalKeys.addReviewSecondKey.currentState.prosList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _proController,
      onChanged: (v) => GlobalKeys.addReviewSecondKey.currentState.prosList[widget.index] = v,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:  ColorClass.greyColor,),
            ),
            fillColor: Colors.white
        ),
    );
  }
}