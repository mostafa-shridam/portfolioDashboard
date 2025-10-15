enum FontSizes {
  small('Small', 1),
  medium('Medium', 4),
  large('Large', 6),
  extraLarge('Extra Large', 8.0),
  huge('Huge', 10.0);

  const FontSizes(this.displayName, this.size);
  final String displayName;
  final double size;

  static FontSizes fromString(String? value) {
    if (value == null) return FontSizes.medium;

    return FontSizes.values.firstWhere(
      (fontSize) => fontSize.name == value || fontSize.displayName == value,
      orElse: () => FontSizes.medium,
    );
  }

  String get toStr => name;
}

extension FontSizeExtension on FontSizes {
  String get displayName => this.displayName;
  double get size => this.size;

  double get titleSize => size + 4.0;
  double get subtitleSize => size + 2.0;
  double get captionSize => size - 2.0;
  double get overlineSize => size - 4.0;

  static FontSizes get defaultFontSize => FontSizes.medium;

  static List<FontSizes> get allSizes => FontSizes.values;
}
