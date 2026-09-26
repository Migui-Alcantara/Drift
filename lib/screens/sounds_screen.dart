import 'package:flutter/material.dart';
import '../data/ambient_sound.dart';

class SoundsScreen extends StatefulWidget {
  final Set<String> playingSounds;
  final Map<String, double> volumes;
  final Future<void> Function(String) onToggleSound;
  final Future<void> Function(String, double) onVolumeChanged;

  const SoundsScreen({
    super.key,
    required this.playingSounds,
    required this.volumes,
    required this.onToggleSound,
    required this.onVolumeChanged,
  });

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  late Set<String> _playingSounds;
  late Map<String, double> _volumes;

  @override
  void initState() {
    super.initState();

    _playingSounds = Set<String>.from(widget.playingSounds);
    _volumes = Map<String, double>.from(widget.volumes);
  }

  Future<void> _toggleSound(String sound) async {
    setState(() {
      if (_playingSounds.contains(sound)) {
        _playingSounds.remove(sound);
      } else {
        _playingSounds.add(sound);
      }
    });

    await widget.onToggleSound(sound);
  }

  Future<void> _changeVolume(
    String sound,
    double volume,
  ) async {
    setState(() {
      _volumes[sound] = volume;
    });

    await widget.onVolumeChanged(
      sound,
      volume,
    );
  }

  double _getVolume(String sound) {
    return _volumes[sound] ?? 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Fixed header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                _dragHandle(),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ambient Sounds',
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

          // Scrollable sound list
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ...ambientSounds.map(
                    (sound) => _soundRow(sound),
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
  
  IconData _getSoundIcon(String sound) {
  switch (sound) {
    case 'Rain':
      return Icons.water_drop;

    case 'Radio Noise':
      return Icons.radio;

    case 'Birds':
      return Icons.flutter_dash;

    case 'Wind':
      return Icons.air;

    case 'Fireplace':
      return Icons.local_fire_department;

    default:
      return Icons.volume_up;
  }
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

  Widget _soundRow(AmbientSound sound) {
    final isPlaying = _playingSounds.contains(sound.name);
    final volume = _getVolume(sound.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPlaying
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
                _getSoundIcon(sound.name),
                color: isPlaying
                    ? const Color(0xFFA78BFA)
                    : Colors.white70,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sound.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _toggleSound(sound.name);
                },
                icon: Icon(
                  isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(
                Icons.volume_mute,
                color: Colors.white54,
                size: 18,
              ),
              Expanded(
                child: Slider(
                  value: volume,
                  min: 0,
                  max: 1,
                  onChanged: (value) {
                    _changeVolume(
                      sound.name,
                      value,
                    );
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
      ),
    );
  }
}