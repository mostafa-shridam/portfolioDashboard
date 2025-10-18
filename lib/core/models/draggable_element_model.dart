class DraggableElementModel {
  final String id;
  final String type; // 'avatar', 'name', 'bio', 'button', etc.
  final double x;
  final double y;
  final double? width;
  final double? height;
  final Map<String, dynamic>? customProperties;
  final DateTime lastModified;

  const DraggableElementModel({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    this.width,
    this.height,
    this.customProperties,
    required this.lastModified,
  });

  factory DraggableElementModel.fromJson(Map<String, dynamic> json) {
    return DraggableElementModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      x: (json['x'] ?? 0.0).toDouble(),
      y: (json['y'] ?? 0.0).toDouble(),
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      customProperties: json['customProperties'],
      lastModified: DateTime.fromMillisecondsSinceEpoch(
        json['lastModified'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'customProperties': customProperties,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  DraggableElementModel copyWith({
    String? id,
    String? type,
    double? x,
    double? y,
    double? width,
    double? height,
    Map<String, dynamic>? customProperties,
    DateTime? lastModified,
  }) {
    return DraggableElementModel(
      id: id ?? this.id,
      type: type ?? this.type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      customProperties: customProperties ?? this.customProperties,
      lastModified: lastModified ?? this.lastModified,
    );
  }
}
