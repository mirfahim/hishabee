import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_training_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/training_video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingVideoPage extends GetResponsiveView<TrainingVideoController> {
  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: controller.obx(
          (state) => Container(
            height: screen.height,
            width: screen.width,
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      height: screen.height * 0.2,
                      width: screen.width,
                      child: Image.asset(
                        "images/topBg.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Text(
                                'training_video'.tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.length,
                              itemBuilder: (BuildContext context, int index) {
                                TrainingVideoResponseModel video = state[index];
                                return VideoPlayer(
                                  videoId: video.videoId,
                                  videoTitle: video.title,
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayer extends StatefulWidget {
  final String videoId;
  final String videoTitle;

  VideoPlayer({this.videoId, this.videoTitle});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    player();
  }

  player() {
    _youtubeController = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(enableCaption: false, autoPlay: false));
  }

  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.45,
      width: size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
            child: Text(
              widget.videoTitle,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: DEFAULT_BLUE,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubeController,
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ),
        ],
      ),
    );
  }
}
