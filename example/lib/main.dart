import 'package:chewie/chewie.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(
      "http://static.jystarfod.com/group1/M00/20/FC/b0QEkl7Say2Ab14YAABgrCYPplM30.m3u8",
      "http://static.jystarfod.com/group1/M00/60/BE/b0QEkl8fzNKAZqnoAAKtdKQ2u4M781.vtt");
}

class _MyHomePageState extends State<MyHomePage> {
  final String link;
  final String subtitleUrl;
  FijkPlayer fijkPlayer;

  _MyHomePageState(this.link, this.subtitleUrl);

  @override
  void initState() {
    super.initState();
    fijkPlayer = FijkPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 2.0,
              child: SubTitleWrapper(
                player: fijkPlayer,
                subtitleController: SubtitleController(
                  subtitleUrl: subtitleUrl,
                  showSubtitles: true,
                  subtitleDecoder: SubtitleDecoder.utf8,
                  subtitleType: SubtitleType.webvtt,
                ),
                subtitleStyle: SubtitleStyle(
                  textColor: Colors.white,
                  hasBorder: true,
                ),
                videoChild: FijkView(
                  height: 600,
                  player: fijkPlayer
                    ..setDataSource(link, autoPlay: true)
                    ..applyOptions(
                        FijkOption()..setHostOption("referer", "kkkanju.com")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    fijkPlayer?.dispose();
    debugPrint('videoPlayerController - dispose()');
  }
}
