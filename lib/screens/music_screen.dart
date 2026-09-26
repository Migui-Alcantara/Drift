import 'package:flutter/material.dart';
import '../data/music_track.dart';

class MusicScreen extends StatefulWidget {
  final MusicTrack? currentTrack;
  final bool isPlaying;
  final double volume;

  final Future<void> Function(MusicTrack track) onPlay;
  final Future<void> Function() onPause;
  final Future<void> Function(double volume) onVolumeChanged;

  const MusicScreen({
    super.key,
    required this.currentTrack,
    required this.isPlaying,
    required this.volume,
    required this.onPlay,
    required this.onPause,
    required this.onVolumeChanged,
  });

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  MusicTrack? _currentTrack;
  bool _isPlaying = false;
  double _volume = 0.5;

  @override
  void initState() {
    super.initState();

    _currentTrack = widget.currentTrack;
    _isPlaying = widget.isPlaying;
    _volume = widget.volume;
  }

  Future<void> _playTrack(MusicTrack track) async {
    setState(() {
      _currentTrack = track;
      _isPlaying = true;
    });

    await widget.onPlay(track);
  }

  Future<void> _pauseMusic() async {
    setState(() {
      _isPlaying = false;
    });

    await widget.onPause();
  }

  Future<void> _changeVolume(double volume) async {
    setState(() {
      _volume = volume;
    });

    await widget.onVolumeChanged(volume);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              0,
            ),
            child: Column(
              children: [
                _dragHandle(),

                const SizedBox(height: 16),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  ...musicTracks.map(
                    (track) => _musicRow(track),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _musicRow(MusicTrack track) {
    final isSelected =
        _currentTrack?.audio == track.audio;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFA78BFA)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.music_note,
                color: isSelected
                    ? const Color(0xFFA78BFA)
                    : Colors.white70,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      track.artist,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  if (isSelected && _isPlaying) {
                    _pauseMusic();
                  } else {
                    _playTrack(track);
                  }
                },
                icon: Icon(
                  isSelected && _isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          if (isSelected) ...[
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(
                  Icons.volume_mute,
                  color: Colors.white54,
                  size: 18,
                ),

                Expanded(
                  child: Slider(
                    value: _volume,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      _changeVolume(value);
                    },
                    activeColor: const Color(0xFFA78BFA),
                    inactiveColor: Colors.white24,
                  ),
                ),

                const Icon(
                  Icons.volume_up,
                  color: Colors.white54,
                  size: 18,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}