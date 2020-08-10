import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 //import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class Player extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return PlayerState();
  }
}

class PlayerState extends State<Player> {
  init() {
    addBean('kkkanju ', dengdan);
    addBean('cctv1', 'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8');
    addBean('cctv2', 'http://ivi.bupt.edu.cn/hls/cctv2.m3u8');
    addBean('CCTV3高清', 'http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8');
    addBean('CCTV4高清', 'http://ivi.bupt.edu.cn/hls/cctv4.m3u8');
    addBean('CCTV5+高清', 'http://ivi.bupt.edu.cn/hls/cctv5phd.m3u8');
    addBean('CCTV6高清', 'http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8');
    addBean('CCTV7高清', 'http://ivi.bupt.edu.cn/hls/cctv7.m3u8');
    addBean('CCTV-8高清 ', 'http://ivi.bupt.edu.cn/hls/cctv8hd.m3u8');
    addBean('CCTV-9高清 ', 'http://ivi.bupt.edu.cn/hls/cctv9.m3u8');
    addBean('CCTV-10高清 ', 'http://ivi.bupt.edu.cn/hls/cctv10.m3u8');
    addBean('CCTV-11高清 ', 'http://ivi.bupt.edu.cn/hls/cctv11.m3u8');
    addBean('CCTV-12高清 ', 'http://ivi.bupt.edu.cn/hls/cctv12.m3u8');
    addBean('CCTV-13高清 ', 'http://ivi.bupt.edu.cn/hls/cctv13.m3u8');
    addBean('CCTV-14高清 ', 'http://ivi.bupt.edu.cn/hls/cctv14.m3u8');
    addBean('CCTV-15高清 ', 'http://ivi.bupt.edu.cn/hls/cctv15.m3u8');
    addBean('CHC高清电影 ', 'http://ivi.bupt.edu.cn/hls/chchd.m3u8');
    addBean('北京卫视高清 ', 'http://ivi.bupt.edu.cn/hls/btv1hd.m3u8');
    addBean('北京文艺高清 ', 'http://ivi.bupt.edu.cn/hls/btv2hd.m3u8');
    addBean('湖南卫视高清 ', 'http://ivi.bupt.edu.cn/hls/hunanhd.m3u8');
    addBean('浙江卫视高清 ', 'http://ivi.bupt.edu.cn/hls/zjhd.m3u8');
    addBean('江苏卫视高清 ', 'http://ivi.bupt.edu.cn/hls/jshd.m3u8');
    addBean('东方卫视高清 ', 'http://ivi.bupt.edu.cn/hls/dfhd.m3u8');
    addBean('安徽卫视高清 ', 'http://ivi.bupt.edu.cn/hls/ahhd.m3u8');
    addBean('黑龙江卫视高清 ', 'http://ivi.bupt.edu.cn/hls/hljhd.m3u8');
    addBean('辽宁卫视高清 ', 'http://ivi.bupt.edu.cn/hls/lnhd.m3u8');
    addBean('深圳卫视高清 ', 'http://ivi.bupt.edu.cn/hls/szhd.m3u8');
    addBean('广东卫视高清 ', 'http://ivi.bupt.edu.cn/hls/gdhd.m3u8');
    addBean('天津卫视高清 ', 'http://ivi.bupt.edu.cn/hls/tjhd.m3u8');
    addBean('湖北卫视高清 ', 'http://ivi.bupt.edu.cn/hls/hbhd.m3u8');
    addBean('东南卫视高清 ', 'http://ivi.bupt.edu.cn/hls/sdhd.m3u8');
    addBean('北京纪实高清 ', 'http://ivi.bupt.edu.cn/hls/btv11hd.m3u8');
    current = _icons[0].url;
  }

  @override
  void initState() {
    super.initState();
    init();
    fijkPlayer = FijkPlayer();
  }

  @override
  void dispose() {
//    ijkMediaController.dispose();
    super.dispose();
    fijkPlayer.dispose();
  }

  addBean(String title, String url) {
    _icons.add(Bean(title, url));
  }

  List<Bean> _icons = []; //保存Icon数据
//  IjkMediaController ijkMediaController = IjkMediaController();

  final String dengdan =
      "http://static.jystarfod.com/group1/M00/20/FC/b0QEkl7Say2Ab14YAABgrCYPplM30.m3u8";
  String zimu="http://static.jystarfod.com/group1/M00/60/BE/b0QEkl8fzNKAZqnoAAKtdKQ2u4M781.vtt";
  String current;

  FijkPlayer fijkPlayer;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          IjkPlayer(
//            mediaController: ijkMediaController
//              ..setNetworkDataSource(current,
//                  headers: {"referer": "kkkanju.com"}, autoPlay: true),
//          ),
          FijkView(
            height: 600,
            player: fijkPlayer
              ..setDataSource(current, autoPlay: true)
              ..applyOptions(
                  FijkOption()..setHostOption("referer", "kkkanju.com")),
          ),


          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //每行三列
                    childAspectRatio: 2),
                itemCount: _icons.length,
                itemBuilder: _getView),
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        child:
//            Icon(ijkMediaController.isPlaying ? Icons.pause : Icons.play_arrow),
//        onPressed: () async {
//          ijkMediaController.isPlaying
//              ? ijkMediaController.pause()
//              : ijkMediaController.play();
//        },
//      ),
    );
  }

  Widget _getView(BuildContext context, int index) {
    Bean bean = _icons[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          fijkPlayer.reset();
          current = bean.url;
        });
      },
      child: Container(
        color: Colors.blue,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        alignment: Alignment.center,
        child: Text(
          bean.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Bean {
  String title;
  String url;

  Bean(this.title, this.url);
}
