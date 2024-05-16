import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<File?> cropImage(File originalImage, Rect cropArea) async {
    try {
      final rawImage =
          await decodeImageFromList(await originalImage.readAsBytes());
      final croppedImage = await cropRawImage(rawImage, cropArea);
      if (croppedImage != null) {
        final croppedBytes = img.encodePng(croppedImage);
        final croppedFile = File(originalImage.path);
        await croppedFile.writeAsBytes(croppedBytes);
        return croppedFile;
      }
    } catch (e) {
      debugPrint('Error cropping image: $e');
    }
    return null;
  }

  static Future<img.Image?> decodeImageFromList(Uint8List bytes) async {
    return img.decodeImage(bytes);
  }

  static Future<img.Image?> cropRawImage(
      img.Image? rawImage, Rect cropArea) async {
    if (rawImage == null) return null;

    final src = cropArea.translate(-cropArea.left, -cropArea.top);
    final croppedImage = img.copyCrop(
      rawImage,
      x: src.left.toInt(),
      y: src.top.toInt(),
      width: src.width.toInt(),
      height: src.height.toInt(),
    );

    return croppedImage;
  }
}
