import 'package:flutter/material.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);
  static const route = "/userProfile";

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: orientation == Orientation.portrait
                      ? 0.35 * width
                      : 0.625 * height),
              pinned: true,
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  top: (orientation == Orientation.portrait ? width : height) /
                      10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => ListTile(
                    title: Text("Index: $index"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  MySliverAppBar({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        _buildCoverPhoto(
            imageUrl:
                "https://see.news/wp-content/uploads/2022/02/Huda-El-Mufti-1.jpg",
            shrinkOffset: shrinkOffset),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            left: 13),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.search_outlined, color: Colors.white),
            right: 60),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            right: 13),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            left: 13,callback: ()=>Navigator.pop(context)),
        _buildAppbarText(
            //username
            username: "Huda El-Mufti",
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            fontSize: 20,
            top: 10),
        _buildAppbarText(
            //tweet Count
            username: "137 Tweets",
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            fontSize: 15,
            top: 35),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.search_outlined, color: Colors.white),
            right: 60,callback: ()=>print("Search Pressed")),
        _buildBarIcon(
            top: 14,
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            right: 13,callback: ()=>print("Menu Pressed")),
        _buildProfilePhoto(
            imageUrl:
                "https://www.pics-place.com/wp-content/uploads/2018/05/%D9%87%D8%AF%D9%89-%D8%A7%D9%84%D9%85%D9%81%D8%AA%D9%8A-6.jpg",
            screenWidth: width,
            shrinkOffset: shrinkOffset,
            context: context),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;
  @override
  double get minExtent => kToolbarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  double profileImageSize(BuildContext context, double opacityFactor,
      double shrinkOffset, double maxSize,
      {bool sized = false}) {
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return (((orientation == Orientation.portrait ? width : height) /
                    opacityFactor >
                maxSize)
            ? maxSize
            : (orientation == Orientation.portrait ? width : height) /
                opacityFactor) *
        (sized ? (1 - shrinkOffset / expandedHeight) : 1);
  }

  Widget _buildBarIcon({
    double? left,
    double? right,
    required double top,
    required Icon icon,
    callback
  }) {
    return Positioned(
        left: left,
        right: right,
        top: top,
        child: GestureDetector(
          onTap: callback,
          child: CircleAvatar(
              backgroundColor: Colors.black45, radius: 15, child: icon),
        ));
  }

  Widget _buildAppbarText(
      {required String username,
      required double screenWidth,
      required double shrinkOffset,
      required double top,
      required double fontSize}) {
    return Positioned(
        left: screenWidth / 5,
        top: top,
        child: Opacity(
          opacity: shrinkOffset / expandedHeight > 0.8 ? 1 : 0,
          child: Text(
            username,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
          ),
        ));
  }

  Widget _buildProfilePhoto(
      {required String imageUrl,
      required screenWidth,
      required double shrinkOffset,
      required BuildContext context}) {
    return Positioned(
      top: expandedHeight / 2 - shrinkOffset,
      left: screenWidth / 25,
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            height: expandedHeight,
            width:
                profileImageSize(context, 3.5, shrinkOffset, 76, sized: true),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: profileImageSize(context, 7.5, shrinkOffset, 35),
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhoto(
      {required String imageUrl, required double shrinkOffset}) {
    return Opacity(
      opacity: 1 - shrinkOffset / expandedHeight,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
