import 'package:flutter/material.dart';

class AudioPlayerProvider  with ChangeNotifier {

  bool _playing = false;
  Duration _songDuration = const Duration(milliseconds: 0);
  Duration _currentTime = const Duration(milliseconds: 0);
  late AnimationController _controller;

  String get songTotalDuration => printDuration(_songDuration);
  String get songCurrentTime => printDuration(_currentTime);

  double get songPercentage => (_songDuration.inSeconds != 0 )
    ? _currentTime.inSeconds / _songDuration.inSeconds
    : 0;

  AnimationController get controller => _controller;
  set controller (AnimationController value) {
    _controller = value;
  }

  bool get playing => _playing;
  set playing (bool value) {
    _playing = value;
    notifyListeners();
  }

  Duration get songDuration => _songDuration;
  set songDuration (Duration value) {
    _songDuration = value;
    notifyListeners();
  }

  Duration get currentTime => _currentTime;
  set currentTime (Duration value) {
    _currentTime = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int value) {
      if (value >= 10) return "$value";
      return '0$value';
    }

    String twoDigitsMinutes =twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds =twoDigits(duration.inSeconds.remainder(60));

    return '$twoDigitsMinutes: $twoDigitsSeconds';
  }
}