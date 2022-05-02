import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/repositories/user_management_repository.dart';
import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([UserManagementRepository,UserManagementRequests])
void main() {
    late UserManagementBloc loginBloc;
    late MockAuthRepository mockAuthRepository;
    setUp(() {
      mockAuthRepository = MockAuthRepository();
      //stub 1
      when(mockAuthRepository.login(username:" " ,password:" ")).thenAnswer((_) async => UserAuthenticationModel.fromJsonLogin(<String,dynamic>{
        'message' : '',
        'token_expiration_date' : '2022-04-23T15:48:54.813Z',
        'access_token' : '',
        'user' : {
          "id":"",
          "name" : "",
          "username" : "" ,
          "email" : "",
          "profile_image_url" : "",
          "cover_image_url" : "",
          "bio":"",
          "website":"",
          "location":"",
          "created_at":"2022-04-23T15:48:54.813Z",
          "isVerified": true,
          "followers_count": 1,
          "following_count": 1,
          "tweets_count": 1,
          "likes_count": 1,
          "isBanned": true,
          "birth_date": "2022-04-23T15:48:54.813Z"
        }
      }));

      //stub 2
      when(mockAuthRepository.login(username:"err" ,password:" ")).thenThrow(Exception("wrong Credentials"));

      //stub 3
      when(mockAuthRepository.signUp(username:" " ,password: " ",date_of_birth: "2022-04-23T15:48:54.813Z",email: " ",gender: " ",name: " ")).thenAnswer((_) async => UserAuthenticationModel.fromJsonLogin(<String,dynamic>{
        'message' : '',
        'token_expiration_date' : '2022-04-23T15:48:54.813Z',
        'access_token' : '',
        'user' : {
          "id":"",
          "name" : "",
          "username" : "" ,
          "email" : "",
          "profile_image_url" : "",
          "cover_image_url" : "",
          "bio":"",
          "website":"",
          "location":"",
          "created_at":"2022-04-23T15:48:54.813Z",
          "isVerified":true,
          "followers_count": 1,
          "following_count": 1,
          "tweets_count": 1,
          "likes_count": 1,
          "isBanned":true,
          "birth_date": "2022-04-23T15:48:54.813Z"
        }
      }));

      //stub 4
      when(mockAuthRepository.signUp(username:"err" ,password: " ",date_of_birth: "2022-04-23T15:48:54.813Z",email: " ",gender: " ",name: " ")).thenThrow(Exception("Invalid Credentials"));


      loginBloc = UserManagementBloc(userManagementRepository:mockAuthRepository);
    });

    tearDown(() {
      loginBloc.close();
    });

    test("Initial State is <LoginInitState()>", () {
      expect(loginBloc.state, InitState());
    });


    blocTest("No state is emitted when no event is added",
        build: () => loginBloc, expect: () => []);



    blocTest<UserManagementBloc,UserManagementStates>("Login Success State is Emitted after Loading when a success response is returned from Login Event", build: ()=>loginBloc,
    act: (bloc)=>bloc.add(LoginButtonPressed(username:" " ,password: " ")),
    expect: ()=>[LoadingState(),LoginSuccessState(UserModel.fromJson({
      "id":"",
      "name" : "",
      "username" : "" ,
      "email" : "",
      "profile_image_url" : "",
      "cover_image_url" : "",
      "bio":"",
      "website":"",
      "location":"",
      "created_at":"2022-04-23T15:48:54.813Z",
      "isVerified":true,
      "followers_count": 1,
      "following_count": 1,
      "tweets_count": 1,
      "likes_count": 1,
      "isBanned":true,
      "birth_date": "2022-04-23T15:48:54.813Z"
    }))]
    );

    blocTest<UserManagementBloc,UserManagementStates>("Login Failure State is Emitted when an exception is thrown due to wrong response",build: ()=>loginBloc,
        act: (bloc)=>bloc.add(LoginButtonPressed(username: "err",password: " ")),
        expect: ()=>[LoadingState(),LoginFailureState(errorMessage: "wrong Credentials")]
    );


    blocTest<UserManagementBloc,UserManagementStates>("SignUp Success State is Emitted after Loading when a success response is returned for SignUp event", build: ()=>loginBloc,
        act: (bloc)=>bloc.add(SignupButtonPressed(username:" " ,password: " ",date: "2022-04-23T15:48:54.813Z",email: " ",gender: " ",name: " ")),
        expect: ()=>[LoadingState(),LoginSuccessState(UserModel.fromJson({
          "id":"",
          "name" : "",
          "username" : "" ,
          "email" : "",
          "profile_image_url" : "",
          "cover_image_url" : "",
          "bio":"",
          "website":"",
          "location":"",
          "created_at":"2022-04-23T15:48:54.813Z",
          "isVerified":true,
          "followers_count": 1,
          "following_count": 1,
          "tweets_count": 1,
          "likes_count": 1,
          "isBanned":true,
          "birth_date": "2022-04-23T15:48:54.813Z"
        }))]
    );

    blocTest<UserManagementBloc,UserManagementStates>("Signup Failure State is Emitted when an exception is thrown due to wrong response", build: ()=>loginBloc,
        act: (bloc)=>bloc.add(SignupButtonPressed(username:"err" ,password: " ",date: "2022-04-23T15:48:54.813Z",email: " ",gender: " ",name: " ")),
        expect: ()=>[LoadingState(),SignupFailureState(errorMessage: " Invalid Credentials")]
    );

}
