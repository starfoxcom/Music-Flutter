import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_flutter/utils/utils.dart' as utils;
import 'package:music_flutter/widgets/action_button_component.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: utils.songs.length,
        itemBuilder: (context, index) {
          String playState = 'Play';
          return utils.songsMetadata[index].trackName != null
              ? Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.memory(
                                utils.songsMetadata[index].albumArt!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      utils.songsMetadata[index].trackName!,
                                      textScaleFactor: 1.5,
                                    ),
                                    Text(utils.songsMetadata[index]
                                        .trackArtistNames![0])
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ActionButtonComponent(
                        borderRadius: 25,
                        labelText: utils.currentSongIndex != index
                            ? playState
                            : utils.player.playing
                                ? 'Stop'
                                : playState,
                        horizontalPadding: 10,
                        onPressedCallback: () {
                          if (utils.player.playing) {
                            if (utils.currentSongIndex != index) {
                              utils.currentSongIndex = index;
                              utils.player.setFilePath(utils.songs[index].path);
                              utils.player.play();
                              setState(() {
                                playState = 'Stop';
                              });
                            } else {
                              utils.player.stop();
                              setState(() {
                                playState = 'Play';
                              });
                            }
                          } else {
                            utils.currentSongIndex = index;
                            utils.player.setFilePath(utils.songs[index].path);
                            utils.player.play();
                            setState(() {
                              playState = 'Stop';
                            });
                          }
                        },
                        onLongPressedCallback: () {},
                      )
                    ],
                  ),
                )
              : Container();
        },
      ),
    ));
  }
}
