class ReportImages{
  String _uuid;
  String _name;
  String _link;

  ReportImages(this._uuid, this._name, this._link);

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get uuid => _uuid;

  set uuid(String value) {
    _uuid = value;
  }
}