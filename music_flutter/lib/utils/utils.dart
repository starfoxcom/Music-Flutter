import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

final player = AudioPlayer();

List<FileSystemEntity> songs = [];
List<Metadata> songsMetadata = [];
int? currentSongIndex;

Directory findRoot(Directory? entity) {
  final Directory parent = entity!.parent;
  if (parent.path == '/storage/emulated/0') return parent;
  return findRoot(parent);
}

getAndroidSongs() async {
  if (await Permission.storage.request().isGranted) {
    final d1 = Directory('/storage/emulated/0/');
    final files = d1.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in files) {
      String path = entity.path;
      if ((path.endsWith('.mp3') || path.endsWith('.m4a')) &&
          !path.contains('Android')) {
        var metadata = await MetadataRetriever.fromFile(File(path));
        var duration = Duration(milliseconds: metadata.trackDuration!);
        if (duration.inSeconds > 60) {
          songs.add(entity);
          songsMetadata.add(metadata);
        }
      }
    }
  } else {
    await Permission.storage.request();
  }
}
