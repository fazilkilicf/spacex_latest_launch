class Launch {
  String name;
  Links links;
  String details;

  Launch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    details = json['details'];
  }
}

class Links {
  Patch patch;
  Links({this.patch});

  Links.fromJson(Map<String, dynamic> json) {
    patch = json['patch'] != null ? new Patch.fromJson(json['patch']) : null;
  }
}

class Patch {
  String small;
  String large;

  Patch({this.small, this.large});

  Patch.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
  }
}
