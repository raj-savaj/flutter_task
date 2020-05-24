class Data {
  List<String> string;

  Data({this.string});

  Data.fromJson(Map<String, dynamic> json) {
    string = json['String'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['String'] = this.string;
    return data;
  }
}