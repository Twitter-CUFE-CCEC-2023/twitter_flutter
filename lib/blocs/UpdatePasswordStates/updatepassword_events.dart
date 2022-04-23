
import 'package:equatable/equatable.dart';

abstract class UpdatePasswordEvents extends Equatable{}

class StartEvent extends UpdatePasswordEvents{
  @override
  List<Object?> get props =>[];
}

class UpdatePasswordButtonPressed extends UpdatePasswordEvents{
  final String oldpassword;
  final String newpassword;
  UpdatePasswordButtonPressed({required this.oldpassword,required this.newpassword});
  @override
  List<Object?> get props =>[oldpassword,newpassword];
}