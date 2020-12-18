import 'package:waverider/models/common.dart';

class Category {
  int id;
  int count;
  String description;
  String link;
  String name;
  String slug;
  String taxonomy;
  int parent;
  List meta;
  List acf;
  Links lLinks;

  Category({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.parent,
    this.meta,
    this.acf,
    this.lLinks,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    description = json['description'];
    link = json['link'];
    name = json['name'];
    slug = json['slug'];
    taxonomy = json['taxonomy'];
    parent = json['parent'];
    if (json['meta'] != null) {
      meta = new List();
      json['meta'].forEach((v) {
        meta.add(v);
      });
    }
    if (json['acf'] != null) {
      acf = new List();
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
    data['parent'] = this.parent;
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
