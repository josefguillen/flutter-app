import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  final int id;
  final String uuid;
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String email;
  final String ip;
  final String macAddress;
  final String website;
  final String image;

  const PersonModel({
    this.id = 0,
    this.uuid = "",
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    this.password = "",
    this.email = "",
    this.ip = "",
    this.website = "",
    this.macAddress = "",
    this.image = "",
  });

  @override
  List<Object?> get props => [
        id,
        uuid,
        firstName,
        lastName,
        username,
        password,
        email,
        ip,
        macAddress,
        website,
        image,
      ];
}
