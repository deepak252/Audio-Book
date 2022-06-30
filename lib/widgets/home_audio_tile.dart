import 'package:audio_book/config/device.dart';
import 'package:audio_book/constants/constants.dart';
import 'package:audio_book/data/sample_audio.dart';
import 'package:audio_book/models/audio.dart';
import 'package:audio_book/screens/selected_audio_screen.dart';
import 'package:flutter/material.dart';

class HomeAudioTile extends StatelessWidget {
  final Audio audio;
  final int index;
  const HomeAudioTile({ Key? key, required this.audio, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Device.height*0.02),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=>SelectedAudioScreen(
              index: index,
              audios: List<Audio>.from(sampleAudio.map((x) => Audio.fromJson(x))),
            ))
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                audio.logo,
                width: Device.width*0.27,
                height: Device.width*0.27,
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audio.title ,
                    style: TextStyle(
                      fontSize: Device.height*0.024,
                      
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    audio.author,
                    style: TextStyle(
                      color: Constants.kColor1,
                      fontSize: Device.height*0.018
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}