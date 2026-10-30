import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_text_source.g.dart';

/// Texto compartido a Rumbo desde otra app. Solo Android lo envía; en iOS
/// (sin Share Extension) no llega nada.
abstract interface class SharedTextSource {
  /// Devuelve el texto pendiente, si hay, y lo da por consumido.
  Future<String?> take();

  /// Avisa cuando llega un texto nuevo con la app ya abierta.
  void listen(VoidCallback onShared);
}

class ChannelSharedTextSource implements SharedTextSource {
  static const MethodChannel _channel = MethodChannel('rumbo/share');

  @override
  Future<String?> take() async {
    try {
      return await _channel.invokeMethod<String>('takeShared');
    } on MissingPluginException {
      return null;
    }
  }

  @override
  void listen(VoidCallback onShared) {
    _channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'shared') onShared();
    });
  }
}

@Riverpod(keepAlive: true)
SharedTextSource sharedTextSource(Ref ref) => ChannelSharedTextSource();
