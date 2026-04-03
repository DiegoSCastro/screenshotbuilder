class UserEntity {
  final String? message;
  final String? timestamp;
  final String? status;
  final ServerInfoEntity? serverInfo;

  UserEntity({this.message, this.timestamp, this.status, this.serverInfo});
}

class ServerInfoEntity {
  final String? platform;
  final double? uptime;

  ServerInfoEntity({this.platform, this.uptime});
}
