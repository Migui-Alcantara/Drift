class Scene {
  final String name;
  final String image;

  Scene({
    required this.name,
    required this.image,
  });
}

final List<Scene> scenes = [
  Scene(
    name: 'Aurora Night',
    image: 'assets/images/aurora_night.jpg',
  ),
  Scene(
    name: 'Cozy Cafe',
    image: 'assets/images/cozy_cafe.jpg',
  ),
  Scene(
    name: 'Rainy Window',
    image: 'assets/images/rainy_window.jpg',
  ),
  Scene(
    name: 'Autumn Leaves',
    image: 'assets/images/autumn_leaves.jpg',
  ),
];