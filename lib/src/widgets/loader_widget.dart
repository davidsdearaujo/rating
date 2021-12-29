import 'dart:async';

import 'package:flutter/material.dart';

import 'busy_indicator.dart';

typedef Loader<T> = Future<T> Function();

class LoaderWidget {
  static bool _showingLoader = false;
//  static Completer _loader;

  static Future<T?> showLoader<T>(
    BuildContext context, {
    required String title,
    String? content,
    Loader<T>? loader,
    Duration? minDuration,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      builder: (context) => AppBottomSheetLoader(title: title, content: content),
    );

    _showingLoader = true;

    T? result;

    final futures = <Future<T?>>[];
    if (minDuration != null) {
      futures.add(
        Future.wait(
          [
            Future.delayed(minDuration, () => null),
            if (loader != null) loader(),
          ],
        ).then((value) => value.firstWhere((element) => element != null, orElse: () => null)),
      );

      result = await Future.any<T?>(futures);
      _hideLoader(context, result);
    }

    return result;
  }

  static void hideLoader(BuildContext context) {
    _hideLoader(context, null);
  }

  static void _hideLoader<T>(BuildContext context, T result) {
    if (!_showingLoader) return;
    _showingLoader = false;
    Navigator.pop(context, result);
  }

//  static Future<bool> showAlert(BuildContext context, String content, {String title, String action = "Entendi"}) async {
//    return showOptions(context, content, title: title, defaultAction: action).then((action) => action != null);
//  }
//
//  static Future<bool> showConfirm(BuildContext context, String content,
//      {String title, String confirmAction = "Sim", String cancelAction = "Não"}) async {
//    return showOptions(context, content, title: title, defaultAction: confirmAction, actions: [cancelAction]).then((action) => action?.isDefault);
//  }

}

class AppBottomSheetLoader<T> extends StatelessWidget {
  final String title;
  final String? content;

  const AppBottomSheetLoader({Key? key, required this.title, this.content}) : super(key: key);

  final double defaultPadding = 20.0;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: defaultPadding * 2),
            BusyIndicator.round(),
            SizedBox(height: title.isNotEmpty || (content?.isNotEmpty ?? false) ? defaultPadding * 1.5 : 0),
            if (title.isNotEmpty)
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 22),
              ),
            SizedBox(height: title.isNotEmpty && (content?.isNotEmpty ?? false) ? defaultPadding * 0.5 : 0),
            if (content?.isNotEmpty ?? false)
              Text(
                content ?? "",
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 15),
              ),
            SizedBox(height: defaultPadding * 2),
          ],
        ),
      ),
    );
  }
}
