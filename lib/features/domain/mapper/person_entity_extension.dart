import 'package:flutterexamapp/features/domain/entity/person/person_entity.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';

extension PersonEntityExtension on PersonEntity {
  PersonModel mapToPersonModel() {
    final data = this;
    return PersonModel(
      id: data.id ?? 0,
      uuid: data.uuid ?? "",
      firstName: data.firstname ?? "",
      lastName: data.lastname ?? "",
      username: data.username ?? "",
      password: data.password ?? "",
      email: data.email ?? "",
      ip: data.ip ?? "",
      macAddress: data.macAddress ?? "",
      website: data.website ?? "",
      image: data.image ?? "",
    );
  }
}