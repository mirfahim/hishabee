import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/training_video_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialOverlay extends ModalRoute<void> {
  final String url;
  final String title;
  TutorialOverlay(this.url, this.title);

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, url),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, String url) {
    Size size = MediaQuery.of(context).size;
    YoutubePlayerController _youtubeController;
    _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: true,
        ));
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.06,
            color: Colors.white,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLUE,
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.4,
            color: Colors.white,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubeController,
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      _youtubeController.pause();
                      Get.to(() => TrainingVideoPage(),
                          binding: AppSettingsBinding());
                    },
                    child: Text(
                      'Watch More',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      _youtubeController.pause();
                      _youtubeController.dispose();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
