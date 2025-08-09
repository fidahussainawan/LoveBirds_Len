import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../models/bird_model.dart';
import '../services/roboflow_service.dart';
import '../services/database_service.dart';

class BirdProvider with ChangeNotifier {
  final RoboflowService _roboflowService = RoboflowService();
  final DatabaseService _databaseService = DatabaseService();
  final ImagePicker _imagePicker = ImagePicker();

  List<BirdIdentification> _identifications = [];
  List<BirdRecord> _birdRecords = [];
  Map<String, int> _birdStats = {};
  bool _isLoading = false;
  String _error = '';
  File? _currentImage;

  List<BirdIdentification> get identifications => _identifications;
  List<BirdRecord> get birdRecords => _birdRecords;
  Map<String, int> get birdStats => _birdStats;
  bool get isLoading => _isLoading;
  String get error => _error;
  File? get currentImage => _currentImage;

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        _currentImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to take photo: $e';
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        _currentImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to pick image: $e';
      notifyListeners();
    }
  }

  Future<void> identifyBird() async {
    if (_currentImage == null) return;

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _identifications = await _roboflowService.identifyBird(_currentImage!);

      if (_identifications.isNotEmpty) {
        // Save the best identification to database
        await _saveBirdRecord(_identifications.first);
      }
    } catch (e) {
      _error = 'Failed to identify bird: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveBirdRecord(BirdIdentification identification) async {
    if (_currentImage == null) return;

    try {
      // Save image to app directory
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'bird_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await _currentImage!.copy('${directory.path}/$fileName');

      // Create bird record
      final record = BirdRecord(
        imagePath: savedImage.path,
        birdName: identification.className,
        confidence: identification.confidence,
        dateTime: DateTime.now(),
      );

      // Save to database
      await _databaseService.insertBirdRecord(record);
      await loadBirdRecords();
      await loadBirdStats();
    } catch (e) {
      _error = 'Failed to save bird record: $e';
      notifyListeners();
    }
  }

  Future<void> loadBirdRecords() async {
    try {
      _birdRecords = await _databaseService.getAllBirdRecords();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load bird records: $e';
      notifyListeners();
    }
  }

  Future<void> loadBirdStats() async {
    try {
      _birdStats = await _databaseService.getBirdStats();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load bird stats: $e';
      notifyListeners();
    }
  }

  Future<void> deleteBirdRecord(int id) async {
    try {
      await _databaseService.deleteBirdRecord(id);
      await loadBirdRecords();
      await loadBirdStats();
    } catch (e) {
      _error = 'Failed to delete bird record: $e';
      notifyListeners();
    }
  }

  void clearCurrentImage() {
    _currentImage = null;
    _identifications = [];
    _error = '';
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  BirdInfo? getBirdInfo(String birdName) {
    final birdDatabase = BirdInfo.getBirdDatabase();
    return birdDatabase[birdName.toLowerCase()];
  }
}