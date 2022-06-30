import 'package:audio_book/config/device.dart';
import 'package:audio_book/constants/constants.dart';
import 'package:flutter/material.dart';

class AudioScreenBottomOptions extends StatelessWidget {
  const AudioScreenBottomOptions({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: Device.width*0.05,),
        Expanded(
          flex: 1,
          child: labelButton(
            imgPath: "assets/images/Bookmark.png", 
            label: "Bookmark"
          ),
        ),
        SizedBox(width: Device.width*0.05,),
        Expanded(
          flex: 1,
          child: labelButton(
            imgPath: "assets/images/Paper.png", 
            label: "Chapter 2"
          ),
        ),
        SizedBox(width: Device.width*0.05,),
        Expanded(
          flex: 1,
          child: labelButton(
            imgPath: "assets/images/Time Square.png", 
            label: "Speed 10x"
          ),
        ),
        SizedBox(width: Device.width*0.05,),
        Expanded(
          flex: 1,
          child: labelButton(
            imgPath: "assets/images/Arrow - Down Square.png", 
            label: "Download"
          ),
        ),
        SizedBox(width: Device.width*0.05,),
      ],
    );
  }


  Widget labelButton({required String imgPath, required String label}){
    return GestureDetector(
      onTap: (){

      },
      child: Column(
        children: [
          Image.asset(
            imgPath,
            width: Device.width*0.08,
          ),
          FittedBox(
            child: Text(
              label,
              style : TextStyle(
                color: Constants.kColor2,
                fontSize: Device.height*0.018
              )
            ),
          )
        ],
      ),
    );
  }
}