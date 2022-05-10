import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostTweet extends StatefulWidget {
  static const String route = '/postTweet';
  const PostTweet({Key? key}) : super(key: key);
  @override
  State<PostTweet> createState() => _PostTweetState();
}

class _PostTweetState extends State<PostTweet> {
  late TextEditingController _tweetTextController;
  late bool tweetEmpty = true;
  List<File> _images = [];
  List<File> _imagesToUpload = [];

  Future pickImage(imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
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
  Widget build(BuildContext context) {
    var bloc = context.read<UserManagementBloc>();
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
              padding: const EdgeInsets.only(right: 16, top: 12, bottom: 8),
              child: ElevatedButton(
                onPressed: !tweetEmpty ? () {} : null,
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
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  ),
                  maximumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 40),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
                child: Text('Tweet'),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 12, top: 8, bottom: 8),
                child: CircleAvatar(
                  backgroundImage: bloc.userdata.profile_image_url.isEmpty
                      ? NetworkImage("")
                      : NetworkImage(bloc.userdata.profile_image_url),
                  radius: 20,
                  backgroundColor: Colors.blue,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _tweetTextController,
                  decoration: InputDecoration(
                    hintText: 'What\'s happening?',
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
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                                    Icon(
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
                                    Icon(
                                      Icons.image_outlined,
                                      size: 35,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ]
                            : []),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Icon(Icons.image_outlined,
                          size: 35, color: Colors.lightBlue),
                    ],
                  ),
                ])
          ],
        ),
      ),
    );
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
            child: Icon(
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
