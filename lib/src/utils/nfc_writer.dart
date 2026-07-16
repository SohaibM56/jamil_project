import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';

class NfcWriter {
  const NfcWriter._();

  static Completer<void>? _activeSession;

  static NdefMessage _uriMessage(String url) {
    final Uint8List payload;
    if (url.startsWith('https://')) {
      payload = Uint8List.fromList([0x04, ...utf8.encode(url.substring(8))]);
    } else {
      payload = Uint8List.fromList([0x00, ...utf8.encode(url)]);
    }

    return NdefMessage(
      records: [
        NdefRecord(
          typeNameFormat: TypeNameFormat.wellKnown,
          type: Uint8List.fromList([0x55]), // 'U' = NDEF URI record
          identifier: Uint8List(0),
          payload: payload,
        ),
      ],
    );
  }

  static Future<void> _stopSessionQuietly({String? alertMessageIos, String? errorMessageIos}) async {
    try {
      await NfcManager.instance.stopSession(
        alertMessageIos: alertMessageIos,
        errorMessageIos: errorMessageIos,
      );
    } catch (_) {}
  }

  static Future<void> writeUrl(String url, {required void Function(String message) onSuccess, required void Function(String message) onError,}) async {
    final availability = await NfcManager.instance.checkAvailability();
    if (availability != NfcAvailability.enabled) {
      onError('NFC is not available on this device.');
      return;
    }

    final message = _uriMessage(url);
    final session = Completer<void>();
    _activeSession = session;

    void finish() {
      if (!session.isCompleted) session.complete();
    }

    await NfcManager.instance.startSession(
      pollingOptions: {
        NfcPollingOption.iso14443,
        NfcPollingOption.iso15693,
        NfcPollingOption.iso18092,
      },
      alertMessageIos: 'Hold your iPhone near the NFC card.',
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef == null || !ndef.isWritable) {
          await _stopSessionQuietly(
            errorMessageIos: 'This card cannot be written to.',
          );
          onError('This NFC card is not writable.');
          finish();
          return;
        }

        if (message.byteLength > ndef.maxSize) {
          await _stopSessionQuietly(
            errorMessageIos: 'Not enough space on this card.',
          );
          onError('Not enough space on this NFC card.');
          finish();
          return;
        }

        try {
          await ndef.write(message: message);
          await _stopSessionQuietly(
            alertMessageIos: 'URL written successfully.',
          );
          onSuccess('URL written to NFC card successfully.');
        } catch (_) {
          await _stopSessionQuietly(
            errorMessageIos: 'Failed to write to the card.',
          );
          onError('Failed to write to the NFC card. Try again.');
        } finally {
          finish();
        }
      },
      onSessionErrorIos: (_) => finish(),
    );

    return session.future;
  }

  static Future<void> cancelSession() async {
    await _stopSessionQuietly();
    final session = _activeSession;
    if (session != null && !session.isCompleted) session.complete();
  }
}
