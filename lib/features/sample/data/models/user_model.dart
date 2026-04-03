import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.message,
    super.timestamp,
    super.status,
    super.serverInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      timestamp: json['timestamp'],
      status: json['status'],
      serverInfo: json['serverInfo'] != null
          ? ServerInfoModel.fromJson(json['serverInfo'])
          : null,
    );
  }
}

class ServerInfoModel extends ServerInfoEntity {
  ServerInfoModel({super.platform, super.uptime});

  factory ServerInfoModel.fromJson(Map<String, dynamic> json) {
    return ServerInfoModel(
      platform: json['platform'],
      uptime: (json['uptime'] as num?)?.toDouble(),
    );
  }
}

class UserRequest {
  final String? username;

  UserRequest({this.username});

  Map<String, dynamic> toJson() {
    return {'userName': username};
  }
}
