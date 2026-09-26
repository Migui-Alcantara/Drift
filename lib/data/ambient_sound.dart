class AmbientSound {
  final String name;
  final String audio;

  AmbientSound({
    required this.name,
    required this.audio,
  });
}

final List<AmbientSound> ambientSounds = [
  AmbientSound(
    name: 'Rain',
    audio: 'assets/audio/rain.wav',
  ),
  AmbientSound(
    name: 'Radio Noise',
    audio: 'assets/audio/radio.mp3',
  ),
  AmbientSound(
    name: 'Birds',
    audio: 'assets/audio/birds.mp3',
  ),
  AmbientSound(
    name: 'Wind',
    audio: 'assets/audio/wind.mp3',
  ),
  AmbientSound(
    name: 'Fireplace',
    audio: 'assets/audio/fireplace.mp3',
  ),
];