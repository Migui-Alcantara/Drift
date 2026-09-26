class MusicTrack {
  final String title;
  final String artist;
  final String audio;

  MusicTrack({
    required this.title,
    required this.artist,
    required this.audio,
  });
}

final List<MusicTrack> musicTracks = [
  MusicTrack(
    title: 'Jay',
    artist: 'Lukrembo',
    audio: 'assets/audio/Jay_Lukrembo.mp3',
  ),
  MusicTrack(
    title: 'Honey Jam',
    artist: 'massobeats',
    audio: 'assets/audio/honeyjam_massobeats.mp3',
  ),
  MusicTrack(
    title: 'Thoughtful',
    artist: 'Pufino',
    audio: 'assets/audio/Thoughtful_Pufino.mp3',
  ),
  MusicTrack(
    title: 'Sleepy Cat',
    artist: 'Alejandro Magaña (A.M.)',
    audio: 'assets/audio/sleepycat_Alejandro_Magana.mp3',
  ),
];