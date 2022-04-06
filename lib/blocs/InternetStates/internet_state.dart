part of 'internet_cubit.dart';

enum ConnectionType {
  wifi,
  mobile,
}


abstract class InternetState extends Equatable{}

class InternetLoading extends InternetState{
  @override
  List<Object?> get props => [];

}

class InternetConnected extends InternetState{
  final ConnectionType connectionType;
InternetConnected(this.connectionType);

  @override
  List<Object?> get props => [ConnectionType];
}

class InternetDisconnected extends InternetState{
  @override
  List<Object?> get props => [];

}