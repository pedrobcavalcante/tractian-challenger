/// Representa o estado de um sensor.
enum SensorStatus {
  operacional,
  critico,
}

extension SensorStatusParser on SensorStatus {
  static SensorStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'operating':
        return SensorStatus.operacional;
      case 'alert':
        return SensorStatus.critico;
      default:
        throw ArgumentError('Invalid SensorStatus value: $value');
    }
  }

  String get stringValue {
    switch (this) {
      case SensorStatus.operacional:
        return 'operating';
      case SensorStatus.critico:
        return 'alert';
    }
  }
}
