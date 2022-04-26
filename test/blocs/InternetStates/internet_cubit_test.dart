import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';

import 'internet_cubit_test.mocks.dart';
@GenerateMocks([Connectivity])
void main(){

connectedTests();
disconnectedTest();
}

void connectedTests()
{
  late Connectivity mockConnectivity;
  late InternetCubit internetCubit;

  setUp((){
    mockConnectivity =MockConnectivity();
    when(mockConnectivity.onConnectivityChanged).thenAnswer((_)=>Stream.value(ConnectivityResult.wifi));
    internetCubit = InternetCubit(mockConnectivity);
  });

  tearDown((){
    internetCubit.close();
  });

  blocTest<InternetCubit,InternetState>("No States Emit When to no changes occur" ,build: ()=>internetCubit, expect: ()=>[] );


  test("Internet Connected State is Fired when Connectivity Result is Wifi", (){
    expect(internetCubit.state,InternetConnected(ConnectionType.wifi));
  });

  test("Internet Connected State is Fired when Connectivity Result is mobile", (){
    expect(internetCubit.state,InternetConnected(ConnectionType.mobile));
  });

  test("Intial State is InernetLoading",(){
    internetCubit = InternetCubit(mockConnectivity);
    expect(internetCubit.state,InternetLoading());
  });
}

void disconnectedTest()
{
  late Connectivity mockConnectivity;
  late InternetCubit internetCubit;

  setUp((){
    mockConnectivity =MockConnectivity();
    when(mockConnectivity.onConnectivityChanged).thenAnswer((_)=>Stream.value(ConnectivityResult.none));
    internetCubit = InternetCubit(mockConnectivity);
  });

  tearDown((){
    internetCubit.close();
  });

  test("InternetDisconnected State is fired when the connectionType is none",(){
    expect(internetCubit.state,InternetDisconnected());
  });

}