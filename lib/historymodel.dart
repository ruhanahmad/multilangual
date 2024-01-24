// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
    final bool? success;
    final String? message;
    final Data? data;

    HistoryModel({
        this.success,
        this.message,
        this.data,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final int? currentPage;
    final Map<String, List<Datum>>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: Map.from(json["data"]!).map((k, v) => MapEntry<String, List<Datum>>(k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    final String? id;
    final String? selectedLang;
    final String? word;
    final String? trans1;
    final String? trans2;
    final int? userId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Datum({
        this.id,
        this.selectedLang,
        this.word,
        this.trans1,
        this.trans2,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        selectedLang: json["selected_lang"],
        word: json["word"],
        trans1: json["trans_1"],
        trans2: json["trans_2"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "selected_lang": selectedLang,
        "word": word,
        "trans_1": trans1,
        "trans_2": trans2,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Link {
    final String? url;
    final String? label;
    final bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}