import '../../domain/entities/cli_details_entity.dart';

class CliDetailsModel extends CliDetailsEntity {
  CliDetailsModel({
    super.name,
    super.latestVersion,
    super.description,
    super.homepage,
    super.fetchedAt,
  });

  factory CliDetailsModel.fromJson(Map<String, dynamic> json) {
    return CliDetailsModel(
      name: json['name'],
      latestVersion: json['latestVersion'],
      description: json['description'],
      homepage: json['homepage'],
      fetchedAt: json['fetchedAt'],
    );
  }
}
