import 'package:equatable/equatable.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

abstract class EditProfileEvents extends Equatable {}

class StartEvent extends EditProfileEvents {
  @override
  List<Object?> get props => [];
}


class EditProfileButtonPressed extends EditProfileEvents {
  final String name, location, website, bio, birth_date, month_day_access, year_access;
  EditProfileButtonPressed(
      {required this.name,
        required this.location,
        required this.website,
        required this.bio,
        required this.birth_date,
        required this.month_day_access,
        required this.year_access,
      });
  @override
  List<Object?> get props => [name, location, website, bio, birth_date,month_day_access,year_access];
}
