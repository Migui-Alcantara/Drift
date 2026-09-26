import 'package:flutter/material.dart';
import '../data/scene.dart';

class ScenesScreen extends StatefulWidget {
  final String selectedScene;
  final Function(String) onSceneSelected;

  const ScenesScreen({
    super.key,
    required this.selectedScene,
    required this.onSceneSelected,
  });

  @override
  State<ScenesScreen> createState() => _ScenesScreenState();
}

class _ScenesScreenState extends State<ScenesScreen> {
  late String _selectedScene;

  @override
  void initState() {
    super.initState();
    _selectedScene = widget.selectedScene;
  }

  void _selectScene(String scene) {
    setState(() {
      _selectedScene = scene;
    });

    widget.onSceneSelected(scene);
  }

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Column(
      children: [
        // This part stays fixed
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              _dragHandle(),

              const SizedBox(height: 16),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a scene',
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

        // Only the scene cards scroll
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ...scenes.map((scene) => _sceneCard(scene)),

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

  Widget _sceneCard(Scene scene) {
    final isSelected = _selectedScene == scene.name;

    return GestureDetector(
      onTap: () {
        _selectScene(scene.name);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                scene.image,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              scene.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}