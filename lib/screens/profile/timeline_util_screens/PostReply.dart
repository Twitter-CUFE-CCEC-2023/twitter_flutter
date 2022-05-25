import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../blocs/tweetsManagement/tweets_management_events.dart';
import '../../../blocs/tweetsManagement/tweets_managment_bloc.dart';
import '../../../blocs/tweetsManagement/tweets_managment_states.dart';

class PostReply extends StatefulWidget {
  static const String route = '/PostReply';
  const PostReply({Key? key}) : super(key: key);
  @override
  State<PostReply> createState() => _PostReplyState();
}

class _PostReplyState extends State<PostReply> {
  late TextEditingController _tweetTextController;
  late bool tweetEmpty = true;
  late String Replay_tweet_id;
  List<File> _images = [];
  List<File> _imagesToUpload = [];

  late String reply_to;

  Future pickImage(imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
        if (_images.length >= 1 && _imagesToUpload.length <= 4) {
          _imagesToUpload.add(File(image.path));
        }
      });
    }
  }

  @override
  initState() {
    super.initState();
    _tweetTextController = TextEditingController();
    _tweetTextController.addListener(() {
      setState(() {
        tweetEmpty = _tweetTextController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _tweetTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    reply_to = ModalRoute.of(context)?.settings.arguments as String;
    var userBloc = context.read<UserManagementBloc>();
    var TweetBloc = context.read<TweetsManagementBloc>();

    return BlocConsumer<TweetsManagementBloc, TweetsManagementStates>(
        listener: (context, state) {
      if (state is TweetsLoadingState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 25,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16, bottom: 6),
                child: ElevatedButton(
                  onPressed: !tweetEmpty
                      ? () {
                          TweetBloc.add(PostReplayButtonPressed(
                            media: _imagesToUpload,
                            access_token: userBloc.access_token,
                            Replay_id: reply_to,
                            tweet_content: _tweetTextController.text,
                          ));
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xff42A5F5);
                      } else {
                        return Colors.blue;
                      }
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xffd2d2d2);
                      } else {
                        return Colors.white;
                      }
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    ),
                    maximumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 40),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  child: Text('Reply'),
                ),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 12, top: 8, bottom: 8),
                        child: CircleAvatar(
                          backgroundImage:
                              userBloc.userdata.profile_image_url.isEmpty
                                  ? NetworkImage("")
                                  : NetworkImage(
                                      userBloc.userdata.profile_image_url),
                          radius: 20,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          maxLength: 280,
                          maxLines: null,
                          controller: _tweetTextController,
                          decoration: const InputDecoration(
                            hintText: 'Tweet your reply',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _imagesToUpload
                            .map((image) => _buildImagetoAddcard(image))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Transform.translate(
            offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _imagesToUpload.isEmpty
                          ? [
                                _buildButtonCard(
                                  ImageSource.camera,
                                  const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 35,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ] +
                              _images
                                  .map((image) => _buildImageCard(image))
                                  .toList() +
                              [
                                _buildButtonCard(
                                  ImageSource.gallery,
                                  const Icon(
                                    Icons.image_outlined,
                                    size: 35,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ]
                          : []),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async =>
                              await pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.image_outlined,
                              size: 30, color: Colors.lightBlue)),
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.gif_box_outlined,
                          size: 30, color: Colors.lightBlue),
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.bar_chart_outlined,
                          size: 30, color: Colors.lightBlue),
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.location_on_outlined,
                          size: 30, color: Colors.lightBlue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildImageCard(File image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_imagesToUpload.contains(image) ||
                _imagesToUpload.length == 4) {
              return;
            }
            _imagesToUpload.add(image);
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            height: 80,
            width: 80,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCard(imageSource, icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          pickImage(imageSource);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          height: 80,
          width: 80,
          child: icon,
        ),
      ),
    );
  }

  Widget _buildImagetoAddcard(image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            height: 200,
            width: 200,
          ),
        ),
        Positioned(
          right: 12,
          top: 4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _imagesToUpload.remove(image);
              });
            },
            child: const Icon(
              Icons.close,
              size: 25,
              color: Colors.black,
            ),
          ),
        )
      ]),
    );
  }
}
