import 'package:smartpay/utilities/imports/generalImport.dart';

import 'dart:ui' as ui;

class HomeViewModel extends BaseModel {
  GlobalKey? _globalKey;

  // Setter for the GlobalKey
  set globalKey(GlobalKey key) => _globalKey = key;
  bool _captureEnabled = false;

  // Getter for captureEnabled
  bool get captureEnabled => _captureEnabled;

  // Method to toggle captureEnabled
  void toggleCaptureEnabled() {
    _captureEnabled = !_captureEnabled;
    captureAndSaveImage();
    notifyListeners();
  }

  fetchSecretQuote(BuildContext context, {required bool noLoading}) {
    runFunctionForApi(
      context,
      noLoading: noLoading,
      functionToRunAfterService: (value) {
        if (value is SecretQuoteModel) {
          secretQuoteString = value.data?.secret;
          notifyListeners();
        } else {
          errorDialogWithClose(context, text: secretQuoteErrorMessage!);
        }
      },
      functionToRunService: secretQuoteService(),
    );
  }

  Future<void> captureAndSaveImage() async {
    try {
      if (_globalKey != null) {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) async {
            RenderRepaintBoundary boundary = _globalKey!.currentContext!
                .findRenderObject() as RenderRepaintBoundary;
            ui.Image image = await boundary.toImage();
            ByteData? byteData =
                await image.toByteData(format: ui.ImageByteFormat.png);
            Uint8List pngBytes = byteData!.buffer.asUint8List();

            // Get the directory for saving images
            final appDir = await getTemporaryDirectory();
            final fileName = DateTime.now().toIso8601String();

            // Save the image
            final path = '${appDir.path}/$fileName.png';
            await File(path).writeAsBytes(pngBytes);
            await ImageGallerySaver.saveFile(path);
            // After the image is saved successfully, set captureEnabled to false
            _captureEnabled = false;
            notifyListeners();
          },
        );
      } else {}
    } catch (e) {}
  }

  void shareUi() async {
    try {
      // Capture the current UI as an image
      final ByteData bytes = await _captureUiAsImage();
      final Uint8List uint8List = bytes.buffer.asUint8List();

      // Convert the image bytes to a file
      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/ui_image.png').writeAsBytes(uint8List);

      // Share the image file using the share package
      await Share.shareFiles([file.path],
          text: 'Check out this awesome Secret Quote!');
    } catch (e) {}
  }

  Future<ByteData> _captureUiAsImage() async {
    Completer<ByteData> completer = Completer();

    try {
      if (_globalKey != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          try {
            // Get the RenderRepaintBoundary for the UI
            final boundary = _globalKey!.currentContext!.findRenderObject()
                as RenderRepaintBoundary;

            // Convert the UI to an image
            final image = await boundary.toImage(pixelRatio: 3.0);
            final byteData =
                await image.toByteData(format: ui.ImageByteFormat.png);

            // Complete the completer with the ByteData
            completer.complete(byteData!);
          } catch (e) {
            // If an error occurs, complete the completer with an error
            completer.completeError('Error capturing UI as image: $e');
          }
        });
      } else {
        throw Exception('GlobalKey is null');
      }
    } catch (e) {
      throw Exception('Error capturing UI as image: $e');
    }

    // Return the future from the completer
    return completer.future;
  }
}
