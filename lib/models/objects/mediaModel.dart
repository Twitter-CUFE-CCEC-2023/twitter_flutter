import 'package:equatable/equatable.dart';

class MediaModel extends Equatable {
  late int media_id;
  late String media;
  late String path;
  late String message;

  MediaModel.fromJson(Map<String, dynamic> json) {
    media_id = json['media_id'];
    media = json['media'];
    path = json['path'];
    message = json['message'];
  }

  @override
  List<Object?> get props => [
        media_id,
        media,
        path,
        message,
      ];
}
