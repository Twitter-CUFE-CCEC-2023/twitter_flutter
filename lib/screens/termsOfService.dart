import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:twitter_flutter/constants.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);
  static String route = '/terms_policy';
  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  AppBar twitterAppBar(
      {required double height,
      required double iconMultiplier,
      required double fontMultiplier}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: Column(
        children: [
          IconButton(
            iconSize: 0.0358 * height * iconMultiplier, //28
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      title: Text(
        'Twitter',
        style: TextStyle(
            color: Colors.black,
            fontSize: 0.0256 * height * fontMultiplier), //20
      ),
    );
  }

  WebView termsWebView({required String url}) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<double> landscapeMultiplier = [1, 1];
    final args = ModalRoute.of(context)?.settings.arguments as WebViewArgs;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        landscapeMultiplier[0] = 1;
        landscapeMultiplier[1] = 1;
      } else {
        landscapeMultiplier[0] = 2;
        landscapeMultiplier[1] = 2.3;
      }
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: twitterAppBar(
                height: screenHeight,
                iconMultiplier: landscapeMultiplier[1],
                fontMultiplier: landscapeMultiplier[1]),
            body: termsWebView(url: args.url),
          ),
        ),
      );
    });
  }
}
