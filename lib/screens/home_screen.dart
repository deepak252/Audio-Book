import 'package:audio_book/config/device.dart';
import 'package:audio_book/constants/constants.dart';
import 'package:audio_book/data/sample_audio.dart';
import 'package:audio_book/models/audio.dart';
import 'package:audio_book/widgets/custom_text_field.dart';
import 'package:audio_book/widgets/home_audio_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({ Key? key }) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Device.height =MediaQuery.of(context).size.height;
    Device.width =MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Constants.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left : Device.height*0.005),
            child: Image.asset(
              "assets/images/Logo.png",
              width: Device.width*0.5,
            ),
          ),
          actions: [
            InkWell(
              child: Image.asset(
                "assets/images/Setting.png",
                width: Device.width*0.08,
              ),
            ),
            SizedBox(width: Device.width*0.04,)
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Device.width*0.04
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Device.height*0.03,),
              Text(
                "My Books",
                style: TextStyle(
                  fontSize: Device.height*0.036,
                  fontWeight: FontWeight.w600,
                  
                ),
              ),
              SizedBox(height: Device.height*0.03,),
              // Search Books Text Field
              CustomTextField(
                controller: _searchController, 
                hintText: "Search Books or Author..."
              ),
              SizedBox(height: Device.height*0.03,),
              // Audios list
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sampleAudio.length,
                  itemBuilder: (context,index){
                    return HomeAudioTile(
                      audio: Audio.fromJson(sampleAudio[index]),
                      index:  index,
                    );
                  },
                ),
              )
            ],
          ),
        ),
        //Bottom Navigation Bar
        bottomNavigationBar: Container(
          height: Device.height*0.09,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Constants.bgColor,
            selectedItemColor: Constants.kColor1,
            unselectedItemColor: const Color(0xFF6A6A8B),
            currentIndex: 2,
            selectedLabelStyle: const TextStyle(
              color: Constants.kColor1,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Color(0xFF6A6A8B),
            ),
                        
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/Home.png",
                  width: Device.width*0.08,
                  color: Constants.kColor2,
                ),
                label : "Home"
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/Search.png",
                  width: Device.width*0.08,
                  color: Constants.kColor2,
                ),
                label : "Search"
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/Document.png",
                  width: Device.width*0.08,
                  color: Constants.kColor1,
                ),
                label : "Library"
              ),
              
            ],
            onTap: (int index) {
            },
          ),
        )
      ),
    );
  }

}