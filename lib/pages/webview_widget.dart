import 'package:flutter/material.dart';
import 'package:sail/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String? url;
  final String? name;

  const WebViewPage({super.key, this.url, this.name});

  @override
  createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController controller = WebViewController();

  final String _javaScript = '''
  const styles = `
  #page-header {
    display: none;
  }
  #main-container {
    padding-top: 0 !important;
  }
  `
  const styleSheet = document.createElement("style")
  styleSheet.innerText = styles
  document.head.appendChild(styleSheet)
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${widget.name}"), centerTitle: true),
        body: WebViewWidget(
            controller: controller
              ..setBackgroundColor(Colors.white)
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(widget.url?.isEmpty == true ? AppStrings.appName : widget.url!))
              ..setNavigationDelegate(NavigationDelegate(
                  onProgress: (int progress) {},
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {
                    controller.runJavaScript(_javaScript);
                  },
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    return NavigationDecision.navigate;
                  }))));
  }
}
