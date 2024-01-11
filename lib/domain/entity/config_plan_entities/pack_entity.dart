import 'package:zetexa_assignment/domain/entity/config_plan_entities/incluions_entity.dart';

class ESIMPackage {
  final String title;
  final DateTime expiresOn;
  final List<Inclusion> inclusions;
  final int price;

  const ESIMPackage({
    required this.title,
    required this.expiresOn,
    required this.inclusions,
    required this.price,
  });
}
