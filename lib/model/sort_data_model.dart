class SortDataModel {
  String? text;
  String? code;

  SortDataModel({
    this.text,
    this.code,
  });

  @override
  bool operator ==(Object other) {
    if (other is! SortDataModel) return false;
    if (code != other.code) return false;
    return true;
  }

  @override
  int get hashCode => code.hashCode;
}
