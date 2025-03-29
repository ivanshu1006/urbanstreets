import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

LoggerService get logger => LoggerService.I;

class LoggerService {
  late Logger _logger;

  @visibleForTesting
  static bool recordCrashlyticsError = true;

  LoggerService._() {
    _logger = Logger();
  }

  static final LoggerService _instance = LoggerService._();

  static LoggerService get I => _instance;

  void debug(
    Object message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void error(
    Object message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  void info(
    Object message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  void warning(
    Object message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }
}
