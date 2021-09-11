import 'package:vivasayi/constants/string_constants.dart';

class ScaleTypeRepository {
  List<String> scaleType() {
    return generateScaleType();
  }

  generateScaleType() => [
        SCALE_TYPE_QTY,
        SCALE_TYPE_KG,
        SCALE_TYPE_GRAM,
        SCALE_TYPE_LITTER,
        SCALE_TYPE_MILLI_LITTER
      ];
}
