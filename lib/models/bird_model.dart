class BirdIdentification {
  final String className;
  final double confidence;
  final int x;
  final int y;
  final int width;
  final int height;

  BirdIdentification({
    required this.className,
    required this.confidence,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory BirdIdentification.fromJson(Map<String, dynamic> json) {
    return BirdIdentification(
      className: json['class'] ?? '',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      x: (json['x'] ?? 0).toInt(),
      y: (json['y'] ?? 0).toInt(),
      width: (json['width'] ?? 0).toInt(),
      height: (json['height'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class': className,
      'confidence': confidence,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}

class BirdRecord {
  final int? id;
  final String imagePath;
  final String birdName;
  final double confidence;
  final DateTime dateTime;
  final String? location;

  BirdRecord({
    this.id,
    required this.imagePath,
    required this.birdName,
    required this.confidence,
    required this.dateTime,
    this.location,
  });

  factory BirdRecord.fromMap(Map<String, dynamic> map) {
    return BirdRecord(
      id: map['id'],
      imagePath: map['imagePath'],
      birdName: map['birdName'],
      confidence: map['confidence'],
      dateTime: DateTime.parse(map['dateTime']),
      location: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'birdName': birdName,
      'confidence': confidence,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
    };
  }
}

class BirdInfo {
  final String name;
  final String scientificName;
  final String description;
  final String habitat;
  final String behavior;
  final List<String> characteristics;

  BirdInfo({
    required this.name,
    required this.scientificName,
    required this.description,
    required this.habitat,
    required this.behavior,
    required this.characteristics,
  });

  static Map<String, BirdInfo> getBirdDatabase() {
    return {
      'lovebird': BirdInfo(
        name: 'Lovebird',
        scientificName: 'Agapornis',
        description: 'Small, colorful parrots known for their affectionate behavior and strong pair bonds.',
        habitat: 'Native to Africa, commonly found in forests, savannas, and shrublands.',
        behavior: 'Social birds that form strong monogamous pairs. They are playful, intelligent, and can be quite vocal.',
        characteristics: [
          'Small size (13-17 cm)',
          'Bright, vibrant colors',
          'Short, blunt tail',
          'Strong, curved beak',
          'Affectionate pair bonding',
        ],
      ),
      'peach-faced lovebird': BirdInfo(
        name: 'Peach-faced Lovebird',
        scientificName: 'Agapornis roseicollis',
        description: 'The most common lovebird species in captivity, known for their peach-colored face and green body.',
        habitat: 'Native to southwestern Africa, particularly the Kalahari Desert region.',
        behavior: 'Highly social and active birds that enjoy climbing and exploring. They can be territorial.',
        characteristics: [
          'Peach to rose-colored face',
          'Green body with blue rump',
          'Approximately 15 cm in length',
          'Lives 15-25 years',
          'Very active and playful',
        ],
      ),
      'fischer\'s lovebird': BirdInfo(
        name: 'Fischer\'s Lovebird',
        scientificName: 'Agapornis fischeri',
        description: 'A beautiful lovebird species with distinctive orange head and white eye-rings.',
        habitat: 'Native to Tanzania, found in small areas south and southeast of Lake Victoria.',
        behavior: 'Gregarious birds that form large flocks. They are excellent climbers and very social.',
        characteristics: [
          'Orange head and throat',
          'Green body with blue tail',
          'White eye-rings',
          '14-15 cm in length',
          'Form large social flocks',
        ],
      ),
    };
  }
}