class PinCodeModal {
  PinCodeModal({
    String? message,
    String? status,
    List<PostOffice>? postOffice,
  }) {
    _message = message;
    _status = status;
    _postOffice = postOffice;
  }

  PinCodeModal.fromJson(dynamic json) {
    _message = json['Message'] as String?;
    _status = json['Status'] as String?;
    if (json['PostOffice'] != null) {
      _postOffice = [];
      json['PostOffice'].forEach((v) {
        _postOffice?.add(PostOffice.fromJson(v));
      });
    }
  }

  String? _message;
  String? _status;
  List<PostOffice>? _postOffice;

  PinCodeModal copyWith({
    String? message,
    String? status,
    List<PostOffice>? postOffice,
  }) =>
      PinCodeModal(
        message: message ?? _message,
        status: status ?? _status,
        postOffice: postOffice ?? _postOffice,
      );

  String? get message => _message;
  String? get status => _status;
  List<PostOffice>? get postOffice => _postOffice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = _message;
    map['Status'] = _status;
    if (_postOffice != null) {
      map['PostOffice'] = _postOffice?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PostOffice {
  PostOffice({
    String? name,
    dynamic description,
    String? branchType,
    String? deliveryStatus,
    String? circle,
    String? district,
    String? division,
    String? region,
    String? block,
    String? state,
    String? country,
    String? pincode,
  }) {
    _name = name;
    _description = description;
    _branchType = branchType;
    _deliveryStatus = deliveryStatus;
    _circle = circle;
    _district = district;
    _division = division;
    _region = region;
    _block = block;
    _state = state;
    _country = country;
    _pincode = pincode;
  }

  PostOffice.fromJson(dynamic json) {
    _name = json['Name'] as String?;
    _description = json['Description'];
    _branchType = json['BranchType'] as String?;
    _deliveryStatus = json['DeliveryStatus'] as String?;
    _circle = json['Circle'] as String?;
    _district = json['District'] as String?;
    _division = json['Division'] as String?;
    _region = json['Region'] as String?;
    _block = json['Block'] as String?;
    _state = json['State'] as String?;
    _country = json['Country'] as String?;
    _pincode = json['Pincode'] as String?;
  }

  String? _name;
  dynamic _description;
  String? _branchType;
  String? _deliveryStatus;
  String? _circle;
  String? _district;
  String? _division;
  String? _region;
  String? _block;
  String? _state;
  String? _country;
  String? _pincode;

  PostOffice copyWith({
    String? name,
    dynamic description,
    String? branchType,
    String? deliveryStatus,
    String? circle,
    String? district,
    String? division,
    String? region,
    String? block,
    String? state,
    String? country,
    String? pincode,
  }) =>
      PostOffice(
        name: name ?? _name,
        description: description ?? _description,
        branchType: branchType ?? _branchType,
        deliveryStatus: deliveryStatus ?? _deliveryStatus,
        circle: circle ?? _circle,
        district: district ?? _district,
        division: division ?? _division,
        region: region ?? _region,
        block: block ?? _block,
        state: state ?? _state,
        country: country ?? _country,
        pincode: pincode ?? _pincode,
      );

  String? get name => _name;
  dynamic get description => _description;
  String? get branchType => _branchType;
  String? get deliveryStatus => _deliveryStatus;
  String? get circle => _circle;
  String? get district => _district;
  String? get division => _division;
  String? get region => _region;
  String? get block => _block;
  String? get state => _state;
  String? get country => _country;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Description'] = _description;
    map['BranchType'] = _branchType;
    map['DeliveryStatus'] = _deliveryStatus;
    map['Circle'] = _circle;
    map['District'] = _district;
    map['Division'] = _division;
    map['Region'] = _region;
    map['Block'] = _block;
    map['State'] = _state;
    map['Country'] = _country;
    map['Pincode'] = _pincode;
    return map;
  }
}
