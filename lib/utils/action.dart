
import 'dart:async';
import 'package:flutter/material.dart';

mixin ActionContext on ChangeNotifier {
  @protected
  final Set<Action> runningActions = {};

  @protected
  Future<bool> canRun(Action action);

  _notify()=> notifyListeners();
}

class Action<I, O> {
  Action(this._context, this._action);

  final ActionContext _context;
  final Future<O> Function(I) _action;

  Completer<O> _resultCompleter = Completer();

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  /// Might return error if not allowed at current state
  Future<O> run(I input) async {
    // assert(input != null || null is I);

    if (_resultCompleter.isCompleted) _resultCompleter = Completer();

    _isRunning = true;
    _context._notify();

    if (await _context.canRun(this)) {
      _context.runningActions.add(this);
      _context._notify();
      _resultCompleter.complete(await _action(input));
      _context.runningActions.remove(this);
    } else {
      _resultCompleter.completeError('Cannot run at current state');
    }

    _isRunning = false;
    _context._notify();

    return _resultCompleter.future;
  }

  /// Might return error if not allowed at current state
  Future<O> get currentResult => _resultCompleter.future;
}
