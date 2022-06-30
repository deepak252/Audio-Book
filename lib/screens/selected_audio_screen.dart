import 'dart:async';
import 'dart:developer';

import 'package:audio_book/config/device.dart';
import 'package:audio_book/constants/constants.dart';
import 'package:audio_book/models/audio.dart';
import 'package:audio_book/widgets/audio_screen_bottom_options.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SelectedAudioScreen extends StatefulWidget {
  int index;
  final List<Audio> audios;
  SelectedAudioScreen({ Key? key, required this.index, required this.audios}) : super(key: key);

  @override
  State<SelectedAudioScreen> createState() => _SelectedAudioScreenState();
}

class _SelectedAudioScreenState extends State<SelectedAudioScreen> {
  final _audioPlayer = AudioPlayer();
  final ValueNotifier<double> _sliderPosNotifier = ValueNotifier(0.0);
  double _maxDuration = 0;
  bool _loading = false;
  Timer? _timer;
  late Audio currentAudio;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  Future initPlayer()async{
    try{
      currentAudio = widget.audios[widget.index];
      _timer?.cancel();
      _sliderPosNotifier.value=0;
      if(mounted){
        setState(() {
          _loading = true;
        });
      }
      final duration = await _audioPlayer.setUrl(currentAudio.filePath);
      if(mounted && duration!=null) {
        setState(() {
          _maxDuration = duration.inSeconds.toDouble();
        });
        playAudio();
      }
      
      log("Duration : $duration");
    }catch(e){
      log("initPlayer error : $e");
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sliderPosNotifier.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Device.height =MediaQuery.of(context).size.height;
    Device.width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: Device.width*0.05),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Constants.kColor2,
            size: Device.height*0.04,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(Device.height*0.004),
          child: Text(
            currentAudio.title,
            style: TextStyle(
              fontSize: Device.height*0.03,
              color: Constants.kColor2,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        actions: [
          InkWell(
            child: Icon(
              Icons.more_horiz,
              color: Constants.kColor2,
              size: Device.height*0.028,
            )
          ),
          SizedBox(width: Device.width*0.05,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Device.width*0.03
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Device.height*0.03,),
              //Audio thumbnail
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: Device.width*0.86,
                    minHeight: Device.width*0.8,
                    maxWidth: Device.width*0.86,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Device.height*0.024),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.kColor1.withOpacity(0.5),
                        blurRadius: 20.0,
                        offset: const Offset(4,10)
                      )
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        currentAudio.logo,
                      )
                    )
                  ),
                ),
              ),
              SizedBox(height: Device.height*0.06,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Device.width*0.05),
                  child: Text(
                    currentAudio.title ,
                    style: TextStyle(
                      fontSize: Device.height*0.026,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 6,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Device.width*0.05),
                  child: Text(
                    currentAudio.author,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Device.height*0.02
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: Device.height*0.02,),
              // const Spacer(),
              //Slider 
              ValueListenableBuilder<double>(
                valueListenable: _sliderPosNotifier,
                builder: (context, position,child) {
                  return Column(
                    children: [
                      Slider(
                        activeColor: Constants.kColor1,
                        inactiveColor: Constants.kColor1.withOpacity(0.3),
                        min: 0,
                        max: _maxDuration.toDouble()+0.01,
                        value: position.toDouble(), 
                        onChanged: (val){
                          if(!_loading){
                            _sliderPosNotifier.value=val;
                            _audioPlayer.seek(Duration(seconds: position.toInt()));
                          }
                        },
                      ),
                      Row(
                        children: [
                          SizedBox(width: Device.width*0.08,),
                          Text(
                            convertSecondsToTime(position.toInt()),
                            style: TextStyle(
                              color: Constants.kColor2.withOpacity(0.7),
                              fontSize: Device.height*0.018
                            ),
                          ),
                          const Spacer(),
                          Text(
                            convertSecondsToTime(_maxDuration.toInt()),
                            style: TextStyle(
                              color: Constants.kColor2.withOpacity(0.7),
                              fontSize: Device.height*0.018
                            ),
                          ),
                          SizedBox(width: Device.width*0.08,),
                        ],
                      )
                    ],
                  );
                }
              ),
              //Player controllers
              Row(
                children: [
                  SizedBox(width: Device.width*0.05,),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Image.asset(
                        "assets/images/Volume Up.png",
                      ),
                    ),
                  ),
                  SizedBox(width: Device.width*0.08,),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        if(widget.index>0 && mounted){
                          setState(() {
                            widget.index--;
                          });
                          initPlayer();
                        }
                      },
                      child: Image.asset(
                        "assets/images/Arrow - Left Circle.png",
                      ),
                    ),
                  ),
                  SizedBox(width: Device.width*0.03,),
                  //Play/Pause button
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: ()async{
                        if(_audioPlayer.playing){
                          pauseAudio();
                        }else{
                          if(_sliderPosNotifier.value.toInt()==_maxDuration.toInt()){
                            await resetAudio();
                          }
                          playAudio();
                        }
                        if(mounted){
                          setState(() {
                            
                          });
                        }
                      },
                      child: Icon(
                        _audioPlayer.playing
                        ? Icons.pause_circle
                        : Icons.play_circle,
                        size: Device.height*0.1,
                        color: Constants.kColor1,
                      ),
                    ),
                  ),
                  SizedBox(width: Device.width*0.03,),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        if(widget.index<widget.audios.length-1 && mounted){
                          setState(() {
                            widget.index++;
                          });
                          initPlayer();
                        }
                      },
                      child: InkWell(
                        child: Image.asset(
                          "assets/images/Arrow - Right Circle.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Device.width*0.08,),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Image.asset(
                        "assets/images/Upload.png",
                      ),
                    ),
                  ),
                  SizedBox(width: Device.width*0.05,),
                ],
              ),
              SizedBox(height: Device.height*0.03,),
              // Audio options
              const AudioScreenBottomOptions(),
              SizedBox(height: Device.height*0.02,)
            ],
          ),
        ),
      ),
    );
  }

  String convertSecondsToTime(int seconds){
    int min = seconds~/60;
    int sec = seconds%60;
    String ss= sec<10 ? "0$sec":sec.toString();
    String mm= min<10 ? "0$min":min.toString();
    return "$mm:$ss";
  }

  Future resetAudio()async{
    _sliderPosNotifier.value=0;
    await _audioPlayer.seek(const Duration(seconds: 0));
  }

  void playAudio(){
    _audioPlayer.play();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer){
        if(_sliderPosNotifier.value<=_maxDuration){
          _sliderPosNotifier.value+=0.01;
        }
        log("${_sliderPosNotifier.value}");
        if(_sliderPosNotifier.value.toInt()==_maxDuration.toInt()){
          timer.cancel();
          pauseAudio();
          setState(() {});
        }
      }
    );
  }

  void pauseAudio(){
    _audioPlayer.pause();
    _timer?.cancel();
  }

  
  
}