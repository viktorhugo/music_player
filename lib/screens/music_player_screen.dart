import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/helpers/helpers.dart';
import 'package:music_player/providers/audio_palyer_provider.dart';
import 'package:music_player/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';


class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          //* Background 
          Background(),

          Column(
            children: [
          
              //* AppBar 
              CustomAppBar(),
          
              //* ImageDisc
              ImageDiscDuration(),
          
              //* Section play or pause 
              PlaySing(),
          
              //* Lyrics
              Expanded(
                child: Lyrics()
              )
          
            ],
          ),
        ],
      )
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return Container(
      child: ListWheelScrollView(
        physics: const BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics.map(
          (line) => Text(line, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 20),)
        ).toList()
      ),
    );
  }
}

class PlaySing extends StatefulWidget {
  const PlaySing({
    super.key,
  });

  @override
  State<PlaySing> createState() => _PlaySingState();
}

class _PlaySingState extends State<PlaySing> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;
  final assetsAudioPlayer = AssetsAudioPlayer();


  @override
  void initState() {

    playAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500 )
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void open() {
    
    final AudioPlayerProvider audioPlayerProvider = Provider.of<AudioPlayerProvider>(context, listen: false);

    assetsAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
    );

    assetsAudioPlayer.currentPosition.listen((Duration duration) {
      audioPlayerProvider.currentTime = duration;
    });

    assetsAudioPlayer.current.listen((playingAudio) {
      audioPlayerProvider.songDuration = playingAudio!.audio.duration;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: [

          //* Song Name
          Column(
            children: [
              Text(
                'Far away',
                style: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 30),
              ),
              Text(
                '-Breaking Benjamin-',
                style: TextStyle( color: Colors.white.withOpacity(0.6), fontSize: 15),
              ),
            ],
          ),

          const Spacer(),

          //* Button paly and pause
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: const Color(0xffF8CB51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, 
              progress: playAnimation
            ),
            onPressed: (){
              
              final AudioPlayerProvider audioPlayerProvider = Provider.of<AudioPlayerProvider>(context, listen: false);

              if (isPlaying) {
                playAnimation.reverse();
                isPlaying = false;
                audioPlayerProvider.controller.stop();
              } else {
                playAnimation.forward();
                isPlaying = true;
                audioPlayerProvider.controller.repeat(); // para que nunca pare
              }
              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetsAudioPlayer.playOrPause();
              }
            },
          )


        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget {
  const ImageDiscDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 50),
      child: const Row(
        children: [
          
          //* Disc
          DiscImage(),

          SizedBox(width: 18,),

          //* Progress Bar
          ProgressBar(),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle =  TextStyle(color: Colors.white.withOpacity(0.5));
    final AudioPlayerProvider audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    final songPercentage = audioPlayerProvider.songPercentage;
    print(audioPlayerProvider.songPercentage);

    return Column(
      children: [
        
        Text(audioPlayerProvider.songTotalDuration, style: textStyle,),
    
        Stack(
          children: [
            Container(
              width: 3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 3,
                height: songPercentage == 0  ? 0 :  230 * songPercentage,
                color: Colors.white.withOpacity(0.8),
              ),
            )
          ],
        ),
    
        Text(audioPlayerProvider.songCurrentTime, style: textStyle,),
    
      ],
    );
  }
}

class DiscImage extends StatelessWidget {
  const DiscImage({super.key});

  @override
  Widget build(BuildContext context) {

    final AudioPlayerProvider audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
          Color(0xff484750),
          Color(0xff1E1C24),
          ]
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [

            SpinPerfect(
              duration: const Duration(seconds: 10),
              infinite: true,
              manualTrigger: true, //* para poder iniciar manualmente
              controller: (animationController) => audioPlayerProvider.controller = animationController,
              child: const Image(image: AssetImage('assets/aurora.jpg'))
            ),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              )
            ),

            Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                color: const Color(0XFF1C1C25),
                borderRadius: BorderRadius.circular(100)
              )
            ),
          ],
        ),
      ),
    );
  }
}