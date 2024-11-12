extension ItemTypeExtension on ItemType {
  String get label {
    switch (this) {
      case ItemType.local:
        return 'Local';
      case ItemType.ativo:
        return 'Ativo';
      case ItemType.componente:
        return 'Componente';
    }
  }

  static ItemType fromString(String value) {
    switch (value) {
      case 'Local':
        return ItemType.local;
      case 'Ativo':
        return ItemType.ativo;
      case 'Componente':
        return ItemType.componente;
      default:
        throw ArgumentError('O valor $value n o   um tipo de item v lido');
    }
  }
}

enum ItemType {
  local,
  ativo,
  componente,
}
