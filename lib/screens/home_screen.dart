import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'scenes_screen.dart';
import 'sounds_screen.dart';
import 'music_screen.dart';
import 'todo_screen.dart';
import '../data/todo_task.dart';
import '../data/scene.dart';
import '../data/ambient_sound.dart';
import '../data/music_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoTask> _tasks = [
    TodoTask(text: 'Study Chapter 4'),
    TodoTask(text: 'Review notes for exam'),
    TodoTask(text: 'Finish Activity 3'),
  ];

  // Ambient sounds
  final Set<String> _playingSounds = {};
  final Map<String, double> _soundVolumes = {};
  final Map<String, AudioPlayer> _soundPlayers = {};

  // Music
  MusicTrack? _currentTrack;
  AudioPlayer? _musicPlayer;
  bool _isMusicPlaying = false;
  double _musicVolume = 0.5;

  // Keeps track of the current song's position
  int _currentTrackIndex = 0;

  Future<void> _playMusic(MusicTrack track) async {
    // Remember which song is currently selected
    _currentTrackIndex = musicTracks.indexOf(track);

    final bool sameTrack =
        _currentTrack?.audio == track.audio;

    setState(() {
      _currentTrack = track;
      _isMusicPlaying = true;
    });

    if (_musicPlayer == null) {
      _musicPlayer = AudioPlayer();

      await _musicPlayer!.setReleaseMode(
        ReleaseMode.release,
      );

      _musicPlayer!.onPlayerComplete.listen((event) {
        _playNextMusic();
      });
    }

    // If it is the same song, just resume it
    if (sameTrack) {
      await _musicPlayer!.setVolume(_musicVolume);
      await _musicPlayer!.resume();
      return;
    }

    // Stop the previous song
    await _musicPlayer!.stop();

    await _musicPlayer!.setVolume(
      _musicVolume,
    );

    // Play the new song
    await _musicPlayer!.play(
      AssetSource(
        track.audio.replaceFirst(
          'assets/',
          '',
        ),
      ),
    );
  }

  Future<void> _pauseMusic() async {
    if (_musicPlayer != null) {
      await _musicPlayer!.pause();
    }

    setState(() {
      _isMusicPlaying = false;
    });
  }

  Future<void> _playNextMusic() async {
    if (musicTracks.isEmpty) {
      return;
    }

    _currentTrackIndex =
        (_currentTrackIndex + 1) % musicTracks.length;

    await _playMusic(
      musicTracks[_currentTrackIndex],
    );
  }

  Future<void> _playPreviousMusic() async {
    if (musicTracks.isEmpty) {
      return;
    }

    _currentTrackIndex =
        (_currentTrackIndex - 1 + musicTracks.length) %
            musicTracks.length;

    await _playMusic(
      musicTracks[_currentTrackIndex],
    );
  }

  Future<void> _changeMusicVolume(double volume) async {
    setState(() {
      _musicVolume = volume;
    });

    if (_musicPlayer != null) {
      await _musicPlayer!.setVolume(volume);
    }
  }

  // Ambient sound controls

  Future<void> _toggleSound(String sound) async {
    final isPlaying = _playingSounds.contains(sound);

    if (isPlaying) {
      final player = _soundPlayers[sound];

      if (player != null) {
        await player.pause();
      }

      setState(() {
        _playingSounds.remove(sound);
      });

      return;
    }

    final ambientSound = ambientSounds.firstWhere(
      (item) => item.name == sound,
    );

    AudioPlayer? player = _soundPlayers[sound];

    if (player == null) {
      player = AudioPlayer();

      await player.setReleaseMode(
        ReleaseMode.loop,
      );

      _soundPlayers[sound] = player;
    }

    final volume = _soundVolumes[sound] ?? 0.5;

    await player.setVolume(volume);

    await player.play(
      AssetSource(
        ambientSound.audio.replaceFirst(
          'assets/',
          '',
        ),
      ),
    );

    setState(() {
      _playingSounds.add(sound);
    });
  }

  Future<void> _changeSoundVolume(
    String sound,
    double volume,
  ) async {
    setState(() {
      _soundVolumes[sound] = volume;
    });

    final player = _soundPlayers[sound];

    if (player != null) {
      await player.setVolume(volume);
    }
  }

  // Scene

  String _selectedScene = 'Aurora Night';

  void _selectScene(String scene) {
    setState(() {
      _selectedScene = scene;
    });
  }

  Scene _getSelectedScene() {
    return scenes.firstWhere(
      (scene) => scene.name == _selectedScene,
    );
  }

  // To-do

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed =
          !_tasks[index].completed;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  Future<void> _addTask() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E2130),
          title: const Text(
            'Add a task',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Enter a task...',
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              filled: true,
              fillColor: const Color(0xFF0F1117),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final task = controller.text.trim();

                if (task.isNotEmpty) {
                  setState(() {
                    _tasks.add(
                      TodoTask(
                        text: task,
                      ),
                    );
                  });
                }

                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Color(0xFFA78BFA),
                ),
              ),
            ),
          ],
        );
      },
    );

    controller.dispose();
  }

  // Date and time
  late DateTime _currentTime;
  Timer? _clockTimer;

  // Pomodoro timer
  Timer? _pomodoroTimer;

  int _remainingSeconds = 25 * 60;

  // Work = true, Break = false
  bool _isWorking = true;

  bool _isRunning = false;

  // Current Pomodoro session
  int _currentSession = 1;

  // Number of work sessions
  final int _totalSessions = 4;

  // Default timer durations
  final int _workMinutes = 25;
  final int _breakMinutes = 5;

@override
void initState() {
  super.initState();

  _currentTime = DateTime.now();

  _clockTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    },
  );

  // Start the first music track when Home opens.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (musicTracks.isNotEmpty) {
      _currentTrackIndex = 0;

      _playMusic(
        musicTracks[_currentTrackIndex],
      );
    }
  });
}

  @override
  void dispose() {
    _clockTimer?.cancel();
    _pomodoroTimer?.cancel();

    for (final player in _soundPlayers.values) {
      player.dispose();
    }

    _musicPlayer?.dispose();

    super.dispose();
  }

  String _formattedDateTime() {
    const weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final weekday =
        weekdays[_currentTime.weekday - 1];

    final month =
        months[_currentTime.month - 1];

    int hour = _currentTime.hour;

    final minute =
        _currentTime.minute
            .toString()
            .padLeft(2, '0');

    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    return '$weekday, $month ${_currentTime.day} · '
        '$hour:$minute $period';
  }

  String _formattedTimer() {
    final minutes =
        (_remainingSeconds ~/ 60)
            .toString()
            .padLeft(2, '0');

    final seconds =
        (_remainingSeconds % 60)
            .toString()
            .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  double _timerProgress() {
    final totalSeconds = _isWorking
        ? _workMinutes * 60
        : _breakMinutes * 60;

    return _remainingSeconds / totalSeconds;
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pomodoroTimer?.cancel();

      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        _isRunning = true;
      });

      _pomodoroTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_remainingSeconds > 0) {
            setState(() {
              _remainingSeconds--;
            });
          } else {
            _moveToNextPhase();
          }
        },
      );
    }
  }

  void _moveToNextPhase() {
    _pomodoroTimer?.cancel();

    setState(() {
      if (_isWorking) {
        // Work session finished.
        // Move to the 5-minute break.
        _isWorking = false;
        _remainingSeconds =
            _breakMinutes * 60;
      } else {
        // Break finished.
        // Move to the next work session.
        if (_currentSession < _totalSessions) {
          _currentSession++;
          _isWorking = true;
          _remainingSeconds =
              _workMinutes * 60;
        } else {
          // All four sessions are finished.
          _isRunning = false;
          _remainingSeconds =
              _workMinutes * 60;
          _currentSession = 1;
          _isWorking = true;
        }
      }
    });

    // Continue automatically if there are still sessions left.
    if (_isRunning) {
      _pomodoroTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_remainingSeconds > 0) {
            setState(() {
              _remainingSeconds--;
            });
          } else {
            _moveToNextPhase();
          }
        },
      );
    }
  }

  void _resetTimer() {
    _pomodoroTimer?.cancel();

    setState(() {
      _remainingSeconds =
          _workMinutes * 60;
      _isWorking = true;
      _isRunning = false;
      _currentSession = 1;
    });
  }

  void _openPanel(
    BuildContext context,
    Widget screen,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          const Color(0xFF1E2130),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: screen,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Selected scene background
          Positioned.fill(
            child: Image.asset(
              _getSelectedScene().image,
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay so text stays readable
          Positioned.fill(
            child: Container(
              color:
                  Colors.black.withOpacity(0.25),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Top information
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      // Date and current song
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formattedDateTime(),
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              const Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 16,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                _currentTrack?.title ??
                                    'No music selected',
                                style:
                                    const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Music controls
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed:
                                    _currentTrack ==
                                            null
                                        ? null
                                        : _playPreviousMusic,
                                icon: const Icon(
                                  Icons.skip_previous,
                                ),
                                color:
                                    Colors.white,
                                disabledColor:
                                    Colors.white38,
                                iconSize: 20,
                                padding:
                                    EdgeInsets.zero,
                                constraints:
                                    const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),

                              IconButton(
                                onPressed:
                                    _currentTrack ==
                                            null
                                        ? null
                                        : () {
                                            if (_isMusicPlaying) {
                                              _pauseMusic();
                                            } else {
                                              _playMusic(
                                                _currentTrack!,
                                              );
                                            }
                                          },
                                icon: Icon(
                                  _isMusicPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                color:
                                    Colors.white,
                                disabledColor:
                                    Colors.white38,
                                iconSize: 20,
                                padding:
                                    EdgeInsets.zero,
                                constraints:
                                    const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),

                              IconButton(
                                onPressed:
                                    _currentTrack ==
                                            null
                                        ? null
                                        : _playNextMusic,
                                icon: const Icon(
                                  Icons.skip_next,
                                ),
                                color:
                                    Colors.white,
                                disabledColor:
                                    Colors.white38,
                                iconSize: 20,
                                padding:
                                    EdgeInsets.zero,
                                constraints:
                                    const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Pomodoro timer
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment:
                                Alignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 140,
                                child:
                                    CircularProgressIndicator(
                                  value:
                                      _timerProgress(),
                                  strokeWidth: 8,
                                  backgroundColor:
                                      Colors.white24,
                                  valueColor:
                                      const AlwaysStoppedAnimation<
                                          Color>(
                                    Color(
                                      0xFFA78BFA,
                                    ),
                                  ),
                                ),
                              ),

                              Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed:
                                        _toggleTimer,
                                    icon: Icon(
                                      _isRunning
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                    color:
                                        Colors.white,
                                    iconSize: 20,
                                  ),

                                  Text(
                                    _formattedTimer(),
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 24,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    _isWorking
                                        ? 'Working'
                                        : 'Break',
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '$_currentSession/$_totalSessions',
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 4),

                          IconButton(
                            onPressed:
                                _resetTimer,
                            icon: const Icon(
                              Icons.refresh,
                            ),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom navigation
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration:
                        BoxDecoration(
                      color: const Color(
                        0xFF1E2130,
                      ).withOpacity(0.9),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,
                      children: [
                        _navItem(
                          context,
                          Icons.landscape,
                          'Scenes',
                          ScenesScreen(
                            selectedScene:
                                _selectedScene,
                            onSceneSelected:
                                _selectScene,
                          ),
                        ),

                        _navItem(
                          context,
                          Icons.water_drop,
                          'Sounds',
                          SoundsScreen(
                            playingSounds:
                                _playingSounds,
                            volumes:
                                _soundVolumes,
                            onToggleSound:
                                _toggleSound,
                            onVolumeChanged:
                                _changeSoundVolume,
                          ),
                        ),

                        _navItem(
                          context,
                          Icons.music_note,
                          'Music',
                          MusicScreen(
                            currentTrack:
                                _currentTrack,
                            isPlaying:
                                _isMusicPlaying,
                            volume:
                                _musicVolume,
                            onPlay:
                                _playMusic,
                            onPause:
                                _pauseMusic,
                            onVolumeChanged:
                                _changeMusicVolume,
                          ),
                        ),

                        _navItem(
                          context,
                          Icons.check_box,
                          'To-do',
                          TodoScreen(
                            tasks: _tasks,
                            onToggle:
                                _toggleTask,
                            onDelete:
                                _deleteTask,
                            onAdd:
                                _addTask,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        _openPanel(context, screen);
      },
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}