import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

final webViewKey = GlobalKey<WebViewContainerState>();

class WebSite extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebSite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewContainer(key: webViewKey),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          // using currentState with question mark to ensure it's not null
          webViewKey.currentState?.reloadWebView();
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.white30,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

    );
  }
}

class WebViewContainer extends StatefulWidget {
  WebViewContainer({Key key}) : super(key: key);

  @override
  WebViewContainerState createState() => WebViewContainerState();
}

class WebViewContainerState extends State<WebViewContainer> {
  WebViewController _webViewController;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();


  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: WebView(

          userAgent:
          "Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36",
          initialUrl: "https://google.com/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future
                .then((value) => _webViewController = value);
            _controllerCompleter.complete(webViewController);
          }),
    );
  }

  void reloadWebView() {
    _webViewController?.reload();
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit this page !!!'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.red,
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          ));
      return Future.value(true);
    }
  }
}


