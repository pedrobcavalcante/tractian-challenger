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
}
