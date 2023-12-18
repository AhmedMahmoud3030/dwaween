class NoteModel{
  int? _id;

  String? _title;
  String? _body;
  String? _kName;
  String? _kText;
  String? _kNameT;
  String? _kTextT;


  NoteModel(this._title, this._body, this._kName, this._kText, this._kNameT, this._kTextT);

  NoteModel.map(dynamic obj){
    _id = obj['id'];
    _title = obj['title'];
    _body = obj['body'];
    _kName = obj['kName'];
    _kText = obj['kText'];
    _kNameT = obj['kNameT'];
    _kTextT = obj['kTextT'];

  }


  Map<String , dynamic > toMap(){
    var map =  Map<String , dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['body'] = _body;
    map['kName'] = _kName;
    map['kText'] = _kText;
    map['kNameT'] = _kNameT;
    map['kTextT'] = _kTextT;

    return map;
  }

  NoteModel.fromMap(Map<String , dynamic> map){
    _id = map['id'] ;
    _title = map['title'] ;
    _body = map['body'] ;
    _kName = map['kName'] ;
    _kText = map['kText'] ;
    _kNameT = map['kNameT'] ;
    _kTextT = map['kTextT'] ;
  }


  set id(int value) {
    _id = value;
  }

  String get kText => _kText as String;
  String get kName => _kName as String;

  String get kTextT => _kTextT as String;
  String get kNameT => _kNameT as String;

  String get body => _body as String;

  String get title => _title as String;

  int get id => _id as int;

  set title(String value) {
    _title = value;
  }

  set body(String value) {
    _body = value;
  }

  set kName(String value) {
    _kName = value;
  }
  set kText(String value) {
    _kText = value;
  }
  set kNameT(String value) {
    _kNameT = value;
  }
  set kTextT(String value) {
    _kTextT = value;
  }
}