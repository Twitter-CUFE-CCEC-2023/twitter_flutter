import 'package:equatable/equatable.dart';

abstract class TabStates extends Equatable{}

class TabinitState extends TabStates {
  @override
  List<Object?> get props => [];
}
class TabLoadingState extends TabStates {
  @override
  List<Object?> get props => [];
}
class TabLoadSuccessState extends TabStates {
  String username;
  TabLoadSuccessState({required this.username});
  @override
  List<Object?> get props => [];
}
class TabLoadFailureState extends TabStates {
  @override
  List<Object?> get props => [];
}
class TabRefreshingState extends TabStates {
  @override
  List<Object?> get props => [];
}
class LocalUpadteState extends TabStates {
  String username;
  LocalUpadteState({required this.username});
  @override
  List<Object?> get props => [];
}
