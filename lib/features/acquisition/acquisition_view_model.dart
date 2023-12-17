import 'package:flutter/material.dart';

import 'acquisition_model.dart';

class AcquisitionViewModel extends ChangeNotifier{
    final List<Acquisition> acquisitionList=[
      Acquisition('Türkçe', '5', '1.1. Anlam'),
      Acquisition('Türkçe', '5', '1.2. Yüklem'),
      Acquisition('Türkçe', '6', '1.1. Eylem'),
      Acquisition('Türkçe', '6', '1.2. Nesne'),
      Acquisition('Türkçe', '7', '1.5. Özne'),
      Acquisition('Türkçe', '7', '1.6. Anlam'),
      Acquisition('Matematik', '5', '1.1. Rakam'),
      Acquisition('Matematik', '5', '1.2. Sayı'),
      Acquisition('Matematik', '6', '1.1. Toplama'),
      Acquisition('Matematik', '6', '1.2. Çıkarma'),
      Acquisition('Matematik', '7', '1.5. Çarpma'),
      Acquisition('Matematik', '7', '1.6. Bölme'),
    ];
}