import 'package:waverider/models/common.dart';

class Region {
  int id;
  int count;
  String description;
  String link;
  String name;
  String slug;
  String taxonomy;
  List meta;
  List acf;
  Links lLinks;

  Region({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.meta,
    this.acf,
    this.lLinks,
  });

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    description = json['description'];
    link = json['link'];
    name = json['name'];
    slug = json['slug'];
    taxonomy = json['taxonomy'];
    if (json['meta'] != null) {
      meta = new List<Null>();
      json['meta'].forEach((v) {
        meta.add(v);
      });
    }
    if (json['acf'] != null) {
      acf = new List<Null>();
      json['acf'].forEach((v) {
        acf.add(v);
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['count'] = this.count;
    data['description'] = this.description;
    data['link'] = this.link;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['taxonomy'] = this.taxonomy;
    if (this.meta != null) {
      data['meta'] = this.meta;
    }
    if (this.acf != null) {
      data['acf'] = this.acf;
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}
