import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../Plugins/get/get_core/src/get_main.dart';

class LoadingTextBloc {
  // ignore: close_sinks
  final streamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => streamController.stream;

  String loadingText = "";

  void changeText(String text) {
    this.loadingText = text;

    this.streamController.sink.add(this.loadingText);
  }
}

class Loadings {
  static LoadingTextBloc bloc = LoadingTextBloc();
  static void show(
    BuildContext context, {
    bool dismiss = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismiss,
      builder: (BuildContext context) => LoadingWidget(),
    );
  }

  static void close(BuildContext context) {
    Navigator.pop(context);
  }
}

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Loadings.close(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width / 3,
                height: Get.width / 3,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 24.0,
              ),
              Material(
                type: MaterialType.transparency,
                child: StreamBuilder(
                  stream: Loadings.bloc.getStream,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: Get.width / 1.5,
                      child: Text(
                        Loadings.bloc.loadingText,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
