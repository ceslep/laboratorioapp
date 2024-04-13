import 'package:flutter/foundation.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';

class HRaytoProvider with ChangeNotifier {
  HRayto _hrayto = HRayto();

  HRayto get hrayto => _hrayto;

  void setData(HRayto hRayto) {
    _hrayto = hRayto;
    notifyListeners();
  }
}
