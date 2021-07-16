import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MUSICPLAYER',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool playing = false;
  IconData button = Icons.play_arrow;
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  Duration _position;
  Duration _duration;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    _position = new Duration();
    _duration = new Duration();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
  }

  Widget slider() {
    return Container(
      width: 300,
      child: Slider(
        value: _position.inSeconds.toDouble(),
        activeColor: Colors.green[500],
        inactiveColor: Colors.greenAccent,
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (value) {
          setState(() {
            audioPlayer.seek(Duration(seconds: value.toInt()));
            value = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[600], Colors.green[300]],
          )),
          child: Padding(
            padding: EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'MUSIC PLAYER',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Start Listening the voice of Heaven',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/image1.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'ALAN WALKER',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        '🎧  On My Way',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(400, 100)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 13)),
                              Text(
                                _position.toString().split('.')[0].substring(2,
                                    _duration.toString().split('.')[0].length),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              slider(),
                              Text(
                                _duration.toString().split('.')[0].substring(2,
                                    _duration.toString().split('.')[0].length),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 13)),
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.skip_previous,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    audioPlayer.seek(Duration(
                                        seconds:
                                            _position.inSeconds.toInt() - 10));
                                  }),
                              CircleAvatar(
                                backgroundColor: Colors.greenAccent,
                                child: Center(
                                  child: IconButton(
                                      icon: Icon(button,
                                          size: 25, color: Colors.green),
                                      onPressed: () {
                                        if (!playing) {
                                          audioCache.play('music.mp3');
                                          setState(() {
                                            button = Icons.pause;
                                            playing = true;
                                          });
                                        } else {
                                          audioPlayer.pause();
                                          setState(() {
                                            button = Icons.play_arrow;
                                            playing = false;
                                          });
                                        }
                                      }),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.skip_next,
                                      size: 40, color: Colors.green),
                                  onPressed: () {
                                    audioPlayer.seek(Duration(
                                        seconds:
                                            _position.inSeconds.toInt() + 10));
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
