class Request {
  String _id;
  String _name;
  String _org;
  String _venue;
  String _reason;
  String first;

  Request(this._id, this._name, this._org, this._venue, this._reason);

  Request.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._org = obj['organization'];
    this._venue = obj['venue'];
    this._reason = obj['reason'];
  }

  String get id => _id;
  String get title => _name;
  String get org => _org;
  String get venue => _venue;
  String get reason => _reason;

  String getName(name){
    this.first = name;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['organization'] = _org;
    map['venue'] = _venue;
    map['reason'] = _reason;

    return map;
  }

  Request.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._org = map['organization'];
    this._venue = map['venue'];
    this._reason = map['reason'];
  }
}
