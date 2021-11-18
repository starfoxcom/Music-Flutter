import 'package:assets_audio_player/assets_audio_player.dart';
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
      body:
          // Build song list
          ListView.builder(
        itemCount: utils.songs.length,
        itemBuilder: (context, index) {
          // Build card for each song or return empty space
          return utils.songs[index].metadata.trackName != null
              ? ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          MemoryImage(utils.songs[index].metadata.albumArt!)),
                  title: Text(
                    utils.songs[index].metadata.trackName!,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  subtitle: Text(
                    (utils.songs[index].metadata.trackDuration != null
                            ? (Duration(
                                        milliseconds: utils.songs[index]
                                            .metadata.trackDuration!)
                                    .label +
                                ' • ')
                            : '0:00 • ') +
                        utils.songs[index].metadata.albumName! +
                        ' • ' +
                        utils.songs[index].metadata.trackArtistNames!
                            .take(2)
                            .join(', '),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ))
              : Container();
        },
      ),
    ));
  }
}

extension on Duration {
  String get label {
    int minutes = inSeconds ~/ 60;
    String seconds = inSeconds - (minutes * 60) > 9
        ? '${inSeconds - (minutes * 60)}'
        : '0${inSeconds - (minutes * 60)}';
    return '$minutes:$seconds';
  }
}
