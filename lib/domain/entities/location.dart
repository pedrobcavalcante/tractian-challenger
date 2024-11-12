import 'company.dart';

class Location extends Company {
  final String? parentId;
  const Location({required super.id, required super.name, this.parentId});
}
