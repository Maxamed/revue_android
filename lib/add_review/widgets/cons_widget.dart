import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

// class ConsWidget extends StatefulWidget{
//   TextEditingController consTextController = TextEditingController();
//   @override
//   State<StatefulWidget> createState() {
//     return ConsWidgetState();
//   }
// }
//
// class ConsWidgetState extends State<ConsWidget>{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           TextFormField(textInputAction: TextInputAction.done,
//             keyboardType: TextInputType.text,
//             controller: widget.consTextController,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//             ),
//             decoration: InputDecoration(
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: ColorClass.greyColor,),
//                 ),
//                 fillColor: Colors.white,
//             )),
//           Align(
//             alignment: Alignment.topRight,
//             child: TextButton.icon(onPressed: (){
//               globalKey.currentState.textfieldListCons.add(ConsWidget());
//               globalKey.currentState.setState(() {
//
//               });
//
//             }, icon: Icon(Icons.add), label: Text("Add More",
//               style: TextStyle(color: ColorClass.blueColor,fontSize: 15),)),
//           ),
//
//         ],
//       ),
//     );
//   }
// }




class ConsTextFields extends StatefulWidget {
  final int index;
  ConsTextFields(this.index);
  @override
  ConsTextFieldsState createState() => ConsTextFieldsState();
}

class ConsTextFieldsState extends State<ConsTextFields> {
  TextEditingController _consController;

  @override
  void initState() {
    super.initState();
    _consController = TextEditingController();
  }

  @override
  void dispose() {
    _consController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _consController.text = GlobalKeys.addReviewSecondKey.currentState.consList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _consController,
      onChanged: (v) => GlobalKeys.addReviewSecondKey.currentState.consList[widget.index] = v,
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