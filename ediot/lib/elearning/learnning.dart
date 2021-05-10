import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class Learnning extends StatefulWidget {
  Learnning({Key? key, this.title = ''}) : super(key: key);
  final String title;
  @override
  _Learnning createState() => _Learnning();
}

class _Learnning extends State<Learnning> {
  // ignore: non_constant_identifier_names
  // infomation Admin User
  bool isVisible = false;
  List<ListAdmin> data_Admin = [
    ListAdmin(
        "AJ jaack Weerachai", "เจ้าหน้าที่ วิศวกรรมศาสตร์", "images/ช้าง.png"),
  ];
  //Creating Dropdown
  // ignore: non_constant_identifier_names
  var _Dropdown = ['week1', 'week2', 'week3', 'week4'];
  // ignore: non_constant_identifier_names
  var _CurrenciesItem = 'week1';
  // creating show-less more
  String descText =
      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.';
  bool descTextShowFlag = false;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(true);
    _controller!.setVolume(1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListAdmin add = data_Admin[0];
    var floatingActionButton;
    return Scaffold(
      appBar: AppBar(
        //Header
        centerTitle: true,
        backgroundColor: Color(0xffAB47BC),
        title: Text("Python For Everybody", style: TextStyle(fontSize: 25)),
      ),
      body: Container(
//profile Admain
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(50))),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/300/30')),
                  ),
                ),
                title: Text(
                  "${add.name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${add.state}"),
              ),
            ),
//Dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 2.0, 0.0),
              child: Container(
                child: DropdownButton<String>(
                    items: _Dropdown.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? newValueSelected) {
                      setState(() {
                        this._CurrenciesItem = newValueSelected!;
                      });
                    },
                    value: _CurrenciesItem),
              ),
            ),

            //Topic
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                "Topic :",
                style: TextStyle(fontSize: 20),
              ),
            ),
//description Show-Less more
            Padding(
              padding: EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: ReadMoreText(
                descText,
                style: TextStyle(
                  fontSize: 15,
                ),
                trimLines: 3,
                colorClickableText: Colors.purple[400],
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(fontSize: 15, color: Colors.purple[400]),
              ),
            ),
//I will create Video
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

//Bottom to Comment
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(80, 30, 80, 0),
                // ignore: missing_required_param
                child: TextButton(
                    child: Text(
                      "แสดงความคิดเห็น",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/commentBox");
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller!.value.isPlaying) {
              _controller!.pause();
            } else {
              _controller!.play();
            }
          });
        },
        child:
            Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

class ListAdmin {
  String name;
  String state;
  String image;

  ListAdmin(this.name, this.state, this.image);
}
