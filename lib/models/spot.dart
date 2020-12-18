import 'package:waverider/models/common.dart';

class Spot {
  int id;
  String date;
  String dateGmt;
  Guid guid;
  String modified;
  String modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Guid title;
  Content content;
  int featuredMedia;
  String template;
  List<int> regions;
  _Acf acf;
  Links lLinks;

  Spot({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.featuredMedia,
    this.template,
    this.regions,
    this.acf,
    this.lLinks,
  });

  Spot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;
    featuredMedia = json['featured_media'];
    template = json['template'];
    regions = json['regions'].cast<int>();
    acf = json['acf'] != null ? new _Acf.fromJson(json['acf']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['featured_media'] = this.featuredMedia;
    data['template'] = this.template;
    data['regions'] = this.regions;
    if (this.acf != null) {
      data['acf'] = this.acf.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class _Acf {
  String lat;
  String lon;
  String subregion;

  _Acf({
    this.lat,
    this.lon,
    this.subregion,
  });

  _Acf.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    subregion = json['subregion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['subregion'] = this.subregion;
    return data;
  }
}
