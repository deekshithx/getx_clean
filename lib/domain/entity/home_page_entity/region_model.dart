class Region {
  final String name;
  final String startPrice;
  final String imagePath;
  final RegionType type;

  Region(
      {required this.name,
      required this.startPrice,
      required this.imagePath,
      required this.type});
}

enum RegionType {
  local,
  regional,
}
