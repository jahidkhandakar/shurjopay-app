import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/gradient_text.dart';

class WebHandler {
  static void open(String url) async {
    if (Uri.tryParse(url) == null) {
      _showError("Invalid URL");
      return;
    }

    Get.to(() => Scaffold(
          appBar: AppBar(
            title: GradientText(
              'ShurjoPay',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            shouldOverrideUrlLoading:
                (controller, navigationAction) async {
              final uri = navigationAction.request.url;
              final urlString = uri.toString();

              if (urlString.startsWith("intent://") ||
                  urlString.startsWith("upi://") ||
                  urlString.contains("bkash") ||
                  urlString.contains("shurjopay")) {
                await launchUrl(Uri.parse(urlString),
                    mode: LaunchMode.externalApplication);
                return NavigationActionPolicy.CANCEL;
              }

              return NavigationActionPolicy.ALLOW;
            },
            onCreateWindow: (controller, createWindowRequest) async {
              final popupUrl =
                  createWindowRequest.request.url.toString();
              await launchUrl(Uri.parse(popupUrl),
                  mode: LaunchMode.externalApplication);
              return false;
            },
            onLoadStop: (controller, uri) async {
              debugPrint("Page loaded: $uri");
            },
          ),
        ));
  }

  static void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
