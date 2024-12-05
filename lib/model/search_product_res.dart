// To parse this JSON data, do
//
//     final searchProductRes = searchProductResFromJson(jsonString);

import 'package:superlabs_interview/superlabs_interview.dart';

SearchProductRes searchProductResFromJson(String str) =>
    SearchProductRes.fromJson(json.decode(str));

String searchProductResToJson(SearchProductRes data) =>
    json.encode(data.toJson());

class SearchProductRes {
  int? statusCode;
  bool? success;
  SearchData? data;
  String? path;
  String? message;
  Meta? meta;

  SearchProductRes({
    this.statusCode,
    this.success,
    this.data,
    this.path,
    this.message,
    this.meta,
  });

  SearchProductRes copyWith({
    int? statusCode,
    bool? success,
    SearchData? data,
    String? path,
    String? message,
    Meta? meta,
  }) =>
      SearchProductRes(
        statusCode: statusCode ?? this.statusCode,
        success: success ?? this.success,
        data: data ?? this.data,
        path: path ?? this.path,
        message: message ?? this.message,
        meta: meta ?? this.meta,
      );

  factory SearchProductRes.fromJson(Map<String, dynamic> json) =>
      SearchProductRes(
        statusCode: json["statusCode"],
        success: json["success"],
        data: json["data"] == null ? null : SearchData.fromJson(json["data"]),
        path: json["path"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "data": data?.toJson(),
        "path": path,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class SearchData {
  List<Product>? products;
  List<BrandElement>? brands;
  List<Attribute>? attributes;
  Map<String, int>? ratingsCounts;

  SearchData({
    this.products,
    this.brands,
    this.attributes,
    this.ratingsCounts,
  });

  SearchData copyWith({
    List<Product>? products,
    List<BrandElement>? brands,
    List<Attribute>? attributes,
    Map<String, int>? ratingsCounts,
  }) =>
      SearchData(
        products: products ?? this.products,
        brands: brands ?? this.brands,
        attributes: attributes ?? this.attributes,
        ratingsCounts: ratingsCounts ?? this.ratingsCounts,
      );

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        brands: json["brands"] == null
            ? []
            : List<BrandElement>.from(
                json["brands"]!.map((x) => BrandElement.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        ratingsCounts: Map.from(json["ratingsCounts"]!)
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "ratingsCounts": Map.from(ratingsCounts!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Attribute {
  String? title;
  String? code;
  List<SearchValue>? values;

  Attribute({
    this.title,
    this.code,
    this.values,
  });

  Attribute copyWith({
    String? title,
    String? code,
    List<SearchValue>? values,
  }) =>
      Attribute(
        title: title ?? this.title,
        code: code ?? this.code,
        values: values ?? this.values,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        title: json["title"],
        code: json["code"],
        values: json["values"] == null
            ? []
            : List<SearchValue>.from(
                json["values"]!.map((x) => SearchValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class SearchValue {
  String? value;
  int? productCount;
  bool isSelected;

  SearchValue({
    this.value,
    this.productCount,
    this.isSelected = false,
  });

  SearchValue copyWith({
    String? value,
    int? productCount,
    bool? isSelected,
  }) =>
      SearchValue(
        value: value ?? this.value,
        productCount: productCount ?? this.productCount,
        isSelected: isSelected ?? this.isSelected,
      );

  factory SearchValue.fromJson(Map<String, dynamic> json) => SearchValue(
        value: json["value"],
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "productCount": productCount,
      };

  @override
  bool operator ==(Object other) {
    if (other is! SearchValue) return false;
    if (value != other.value) return false;
    return true;
  }

  @override
  int get hashCode => value.hashCode;
}

class BrandElement {
  String? id;
  String? handle;
  String? name;
  int? productCount;
  bool isSelected;

  BrandElement({
    this.id,
    this.handle,
    this.name,
    this.productCount,
    this.isSelected = false,
  });

  BrandElement copyWith({
    String? id,
    String? handle,
    String? name,
    int? productCount,
    bool? isSelected,
  }) =>
      BrandElement(
        id: id ?? this.id,
        handle: handle ?? this.handle,
        name: name ?? this.name,
        productCount: productCount ?? this.productCount,
        isSelected: isSelected ?? this.isSelected,
      );

  factory BrandElement.fromJson(Map<String, dynamic> json) => BrandElement(
        id: json["id"],
        handle: json["handle"],
        name: json["name"],
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "handle": handle,
        "name": name,
        "productCount": productCount,
      };

  @override
  bool operator ==(Object other) {
    if (other is! BrandElement) return false;
    if (id != other.id) return false;
    return true;
  }

  @override
  int get hashCode => id.hashCode;
}

class Product {
  String? id;
  String? title;
  dynamic subtitle;
  String? description;
  String? handle;
  dynamic weight;
  dynamic height;
  dynamic width;
  dynamic length;
  dynamic hsCode;
  dynamic originCountry;
  dynamic midCode;
  dynamic material;
  Metadata? metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? tags;
  String? brandId;
  String? status;
  dynamic createdById;
  String? productCategoryId;
  String? thumbnail;
  String? productAttributeGroupId;
  String? metaTitle;
  String? metaDescription;
  ProductBrand? brand;
  ProductCategory? productCategory;
  List<dynamic>? productCollections;
  List<ProductValuesForAttribute>? productValuesForAttribute;
  List<Variant>? variants;
  List<ProductImage>? productImages;
  List<Review>? reviews;
  Count? count;
  double? averageRating;
  int? priceStart;
  dynamic priceEnd;

  Product({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.handle,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.brandId,
    this.status,
    this.createdById,
    this.productCategoryId,
    this.thumbnail,
    this.productAttributeGroupId,
    this.metaTitle,
    this.metaDescription,
    this.brand,
    this.productCategory,
    this.productCollections,
    this.productValuesForAttribute,
    this.variants,
    this.productImages,
    this.reviews,
    this.count,
    this.averageRating,
    this.priceStart,
    this.priceEnd,
  });

  Product copyWith({
    String? id,
    String? title,
    dynamic subtitle,
    String? description,
    String? handle,
    dynamic weight,
    dynamic height,
    dynamic width,
    dynamic length,
    dynamic hsCode,
    dynamic originCountry,
    dynamic midCode,
    dynamic material,
    Metadata? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? brandId,
    String? status,
    dynamic createdById,
    String? productCategoryId,
    String? thumbnail,
    String? productAttributeGroupId,
    String? metaTitle,
    String? metaDescription,
    ProductBrand? brand,
    ProductCategory? productCategory,
    List<dynamic>? productCollections,
    List<ProductValuesForAttribute>? productValuesForAttribute,
    List<Variant>? variants,
    List<ProductImage>? productImages,
    List<Review>? reviews,
    Count? count,
    double? averageRating,
    int? priceStart,
    dynamic priceEnd,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        description: description ?? this.description,
        handle: handle ?? this.handle,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        width: width ?? this.width,
        length: length ?? this.length,
        hsCode: hsCode ?? this.hsCode,
        originCountry: originCountry ?? this.originCountry,
        midCode: midCode ?? this.midCode,
        material: material ?? this.material,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tags: tags ?? this.tags,
        brandId: brandId ?? this.brandId,
        status: status ?? this.status,
        createdById: createdById ?? this.createdById,
        productCategoryId: productCategoryId ?? this.productCategoryId,
        thumbnail: thumbnail ?? this.thumbnail,
        productAttributeGroupId:
            productAttributeGroupId ?? this.productAttributeGroupId,
        metaTitle: metaTitle ?? this.metaTitle,
        metaDescription: metaDescription ?? this.metaDescription,
        brand: brand ?? this.brand,
        productCategory: productCategory ?? this.productCategory,
        productCollections: productCollections ?? this.productCollections,
        productValuesForAttribute:
            productValuesForAttribute ?? this.productValuesForAttribute,
        variants: variants ?? this.variants,
        productImages: productImages ?? this.productImages,
        reviews: reviews ?? this.reviews,
        count: count ?? this.count,
        averageRating: averageRating ?? this.averageRating,
        priceStart: priceStart ?? this.priceStart,
        priceEnd: priceEnd ?? this.priceEnd,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        handle: json["handle"],
        weight: json["weight"],
        height: json["height"],
        width: json["width"],
        length: json["length"],
        hsCode: json["hs_code"],
        originCountry: json["origin_country"],
        midCode: json["mid_code"],
        material: json["material"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        brandId: json["brandId"],
        status: json["status"],
        createdById: json["createdById"],
        productCategoryId: json["productCategoryId"],
        thumbnail: json["thumbnail"],
        productAttributeGroupId: json["productAttributeGroupId"],
        metaTitle: json["metaTitle"],
        metaDescription: json["metaDescription"],
        brand:
            json["brand"] == null ? null : ProductBrand.fromJson(json["brand"]),
        productCategory: json["productCategory"] == null
            ? null
            : ProductCategory.fromJson(json["productCategory"]),
        productCollections: json["productCollections"] == null
            ? []
            : List<dynamic>.from(json["productCollections"]!.map((x) => x)),
        productValuesForAttribute: json["productValuesForAttribute"] == null
            ? []
            : List<ProductValuesForAttribute>.from(
                json["productValuesForAttribute"]!
                    .map((x) => ProductValuesForAttribute.fromJson(x))),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        productImages: json["productImages"] == null
            ? []
            : List<ProductImage>.from(
                json["productImages"]!.map((x) => ProductImage.fromJson(x))),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
        averageRating: json["averageRating"]?.toDouble(),
        priceStart: json["priceStart"],
        priceEnd: json["priceEnd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "handle": handle,
        "weight": weight,
        "height": height,
        "width": width,
        "length": length,
        "hs_code": hsCode,
        "origin_country": originCountry,
        "mid_code": midCode,
        "material": material,
        "metadata": metadata?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "brandId": brandId,
        "status": status,
        "createdById": createdById,
        "productCategoryId": productCategoryId,
        "thumbnail": thumbnail,
        "productAttributeGroupId": productAttributeGroupId,
        "metaTitle": metaTitle,
        "metaDescription": metaDescription,
        "brand": brand?.toJson(),
        "productCategory": productCategory?.toJson(),
        "productCollections": productCollections == null
            ? []
            : List<dynamic>.from(productCollections!.map((x) => x)),
        "productValuesForAttribute": productValuesForAttribute == null
            ? []
            : List<dynamic>.from(
                productValuesForAttribute!.map((x) => x.toJson())),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "productImages": productImages == null
            ? []
            : List<dynamic>.from(productImages!.map((x) => x.toJson())),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "_count": count?.toJson(),
        "averageRating": averageRating,
        "priceStart": priceStart,
        "priceEnd": priceEnd,
      };
}

class ProductBrand {
  String? id;
  String? title;
  String? description;
  String? handle;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? status;
  dynamic metadata;
  dynamic createdById;

  ProductBrand({
    this.id,
    this.title,
    this.description,
    this.handle,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
    this.metadata,
    this.createdById,
  });

  ProductBrand copyWith({
    String? id,
    String? title,
    String? description,
    String? handle,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? status,
    dynamic metadata,
    dynamic createdById,
  }) =>
      ProductBrand(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        handle: handle ?? this.handle,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        status: status ?? this.status,
        metadata: metadata ?? this.metadata,
        createdById: createdById ?? this.createdById,
      );

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        handle: json["handle"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        status: json["status"],
        metadata: json["metadata"],
        createdById: json["createdById"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "handle": handle,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "status": status,
        "metadata": metadata,
        "createdById": createdById,
      };
}

class Count {
  int? lineItems;

  Count({
    this.lineItems,
  });

  Count copyWith({
    int? lineItems,
  }) =>
      Count(
        lineItems: lineItems ?? this.lineItems,
      );

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        lineItems: json["lineItems"],
      );

  Map<String, dynamic> toJson() => {
        "lineItems": lineItems,
      };
}

class Metadata {
  String? excerpt;

  Metadata({
    this.excerpt,
  });

  Metadata copyWith({
    String? excerpt,
  }) =>
      Metadata(
        excerpt: excerpt ?? this.excerpt,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        excerpt: json["excerpt"],
      );

  Map<String, dynamic> toJson() => {
        "excerpt": excerpt,
      };
}

class ProductCategory {
  String? id;
  String? name;
  String? description;
  String? handle;
  dynamic image;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? rank;
  String? fullPath;
  String? fullPathHandle;
  dynamic metadata;
  String? createdById;
  dynamic parent;

  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.handle,
    this.image,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.rank,
    this.fullPath,
    this.fullPathHandle,
    this.metadata,
    this.createdById,
    this.parent,
  });

  ProductCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? handle,
    dynamic image,
    dynamic parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? rank,
    String? fullPath,
    String? fullPathHandle,
    dynamic metadata,
    String? createdById,
    dynamic parent,
  }) =>
      ProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        handle: handle ?? this.handle,
        image: image ?? this.image,
        parentId: parentId ?? this.parentId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        rank: rank ?? this.rank,
        fullPath: fullPath ?? this.fullPath,
        fullPathHandle: fullPathHandle ?? this.fullPathHandle,
        metadata: metadata ?? this.metadata,
        createdById: createdById ?? this.createdById,
        parent: parent ?? this.parent,
      );

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        handle: json["handle"],
        image: json["image"],
        parentId: json["parentId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        rank: json["rank"],
        fullPath: json["fullPath"],
        fullPathHandle: json["fullPathHandle"],
        metadata: json["metadata"],
        createdById: json["createdById"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "handle": handle,
        "image": image,
        "parentId": parentId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "rank": rank,
        "fullPath": fullPath,
        "fullPathHandle": fullPathHandle,
        "metadata": metadata,
        "createdById": createdById,
        "parent": parent,
      };
}

class ProductImage {
  String? id;
  String? productId;
  String? image;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdById;
  dynamic productVariantId;

  ProductImage({
    this.id,
    this.productId,
    this.image,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.createdById,
    this.productVariantId,
  });

  ProductImage copyWith({
    String? id,
    String? productId,
    String? image,
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic createdById,
    dynamic productVariantId,
  }) =>
      ProductImage(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        image: image ?? this.image,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdById: createdById ?? this.createdById,
        productVariantId: productVariantId ?? this.productVariantId,
      );

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["productId"],
        image: json["image"],
        order: json["order"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdById: json["createdById"],
        productVariantId: json["productVariantId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "image": image,
        "order": order,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdById": createdById,
        "productVariantId": productVariantId,
      };
}

class ProductValuesForAttribute {
  String? id;
  String? productId;
  String? productAttributeId;
  String? productAttributeValueId;
  dynamic value;
  ProductAttribute? productAttribute;
  ProductAttributeValue? productAttributeValue;

  ProductValuesForAttribute({
    this.id,
    this.productId,
    this.productAttributeId,
    this.productAttributeValueId,
    this.value,
    this.productAttribute,
    this.productAttributeValue,
  });

  ProductValuesForAttribute copyWith({
    String? id,
    String? productId,
    String? productAttributeId,
    String? productAttributeValueId,
    dynamic value,
    ProductAttribute? productAttribute,
    ProductAttributeValue? productAttributeValue,
  }) =>
      ProductValuesForAttribute(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productAttributeId: productAttributeId ?? this.productAttributeId,
        productAttributeValueId:
            productAttributeValueId ?? this.productAttributeValueId,
        value: value ?? this.value,
        productAttribute: productAttribute ?? this.productAttribute,
        productAttributeValue:
            productAttributeValue ?? this.productAttributeValue,
      );

  factory ProductValuesForAttribute.fromJson(Map<String, dynamic> json) =>
      ProductValuesForAttribute(
        id: json["id"],
        productId: json["productId"],
        productAttributeId: json["productAttributeId"],
        productAttributeValueId: json["productAttributeValueId"],
        value: json["value"],
        productAttribute: json["productAttribute"] == null
            ? null
            : ProductAttribute.fromJson(json["productAttribute"]),
        productAttributeValue: json["productAttributeValue"] == null
            ? null
            : ProductAttributeValue.fromJson(json["productAttributeValue"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productAttributeId": productAttributeId,
        "productAttributeValueId": productAttributeValueId,
        "value": value,
        "productAttribute": productAttribute?.toJson(),
        "productAttributeValue": productAttributeValue?.toJson(),
      };
}

class ProductAttribute {
  String? id;
  String? title;
  String? type;
  String? code;
  bool? isRequired;
  bool? isUnique;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic metadata;
  String? createdById;

  ProductAttribute({
    this.id,
    this.title,
    this.type,
    this.code,
    this.isRequired,
    this.isUnique,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.createdById,
  });

  ProductAttribute copyWith({
    String? id,
    String? title,
    String? type,
    String? code,
    bool? isRequired,
    bool? isUnique,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic metadata,
    String? createdById,
  }) =>
      ProductAttribute(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        code: code ?? this.code,
        isRequired: isRequired ?? this.isRequired,
        isUnique: isUnique ?? this.isUnique,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        metadata: metadata ?? this.metadata,
        createdById: createdById ?? this.createdById,
      );

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      ProductAttribute(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        code: json["code"],
        isRequired: json["isRequired"],
        isUnique: json["isUnique"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        metadata: json["metadata"],
        createdById: json["createdById"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "code": code,
        "isRequired": isRequired,
        "isUnique": isUnique,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "metadata": metadata,
        "createdById": createdById,
      };
}

class ProductAttributeValue {
  String? id;
  String? productAttributeId;
  String? value;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic metadata;

  ProductAttributeValue({
    this.id,
    this.productAttributeId,
    this.value,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  ProductAttributeValue copyWith({
    String? id,
    String? productAttributeId,
    String? value,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic metadata,
  }) =>
      ProductAttributeValue(
        id: id ?? this.id,
        productAttributeId: productAttributeId ?? this.productAttributeId,
        value: value ?? this.value,
        position: position ?? this.position,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        metadata: metadata ?? this.metadata,
      );

  factory ProductAttributeValue.fromJson(Map<String, dynamic> json) =>
      ProductAttributeValue(
        id: json["id"],
        productAttributeId: json["productAttributeId"],
        value: json["value"],
        position: json["position"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        metadata: json["metadata"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productAttributeId": productAttributeId,
        "value": value,
        "position": position,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "metadata": metadata,
      };
}

class Review {
  int? rating;

  Review({
    this.rating,
  });

  Review copyWith({
    int? rating,
  }) =>
      Review(
        rating: rating ?? this.rating,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
      };
}

class Variant {
  String? id;
  String? productId;
  String? title;
  String? sku;
  dynamic barcode;
  dynamic ean;
  dynamic upc;
  int? inventoryQuantity;
  bool? allowBackOrder;
  bool? manageInventory;
  dynamic hsCode;
  dynamic originCountry;
  dynamic midCode;
  dynamic material;
  dynamic weight;
  dynamic height;
  dynamic length;
  dynamic width;
  int? variantRank;
  int? price;
  int? specialPrice;
  dynamic specialPriceStartDate;
  dynamic specialPriceEndDate;
  int? inventory;
  dynamic metadata;
  DateTime? createdAt;
  dynamic deletedAt;
  DateTime? updatedAt;
  String? thumbnail;
  dynamic createdById;
  List<dynamic>? prices;
  int? originalPrice;
  int? currentPrice;
  Map? salePrices;

  Variant({
    this.id,
    this.productId,
    this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.inventoryQuantity,
    this.allowBackOrder,
    this.manageInventory,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.weight,
    this.height,
    this.length,
    this.width,
    this.variantRank,
    this.price,
    this.specialPrice,
    this.specialPriceStartDate,
    this.specialPriceEndDate,
    this.inventory,
    this.metadata,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.thumbnail,
    this.createdById,
    this.prices,
    this.originalPrice,
    this.currentPrice,
    this.salePrices,
  });

  Variant copyWith({
    String? id,
    String? productId,
    String? title,
    String? sku,
    dynamic barcode,
    dynamic ean,
    dynamic upc,
    int? inventoryQuantity,
    bool? allowBackOrder,
    bool? manageInventory,
    dynamic hsCode,
    dynamic originCountry,
    dynamic midCode,
    dynamic material,
    dynamic weight,
    dynamic height,
    dynamic length,
    dynamic width,
    int? variantRank,
    int? price,
    int? specialPrice,
    dynamic specialPriceStartDate,
    dynamic specialPriceEndDate,
    int? inventory,
    dynamic metadata,
    DateTime? createdAt,
    dynamic deletedAt,
    DateTime? updatedAt,
    String? thumbnail,
    dynamic createdById,
    List<dynamic>? prices,
    int? originalPrice,
    int? currentPrice,
    Map? salePrices,
  }) =>
      Variant(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        title: title ?? this.title,
        sku: sku ?? this.sku,
        barcode: barcode ?? this.barcode,
        ean: ean ?? this.ean,
        upc: upc ?? this.upc,
        inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
        allowBackOrder: allowBackOrder ?? this.allowBackOrder,
        manageInventory: manageInventory ?? this.manageInventory,
        hsCode: hsCode ?? this.hsCode,
        originCountry: originCountry ?? this.originCountry,
        midCode: midCode ?? this.midCode,
        material: material ?? this.material,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        length: length ?? this.length,
        width: width ?? this.width,
        variantRank: variantRank ?? this.variantRank,
        price: price ?? this.price,
        specialPrice: specialPrice ?? this.specialPrice,
        specialPriceStartDate:
            specialPriceStartDate ?? this.specialPriceStartDate,
        specialPriceEndDate: specialPriceEndDate ?? this.specialPriceEndDate,
        inventory: inventory ?? this.inventory,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        thumbnail: thumbnail ?? this.thumbnail,
        createdById: createdById ?? this.createdById,
        prices: prices ?? this.prices,
        originalPrice: originalPrice ?? this.originalPrice,
        currentPrice: currentPrice ?? this.currentPrice,
        salePrices: salePrices ?? this.salePrices,
      );

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["productId"],
        title: json["title"],
        sku: json["sku"],
        barcode: json["barcode"],
        ean: json["ean"],
        upc: json["upc"],
        inventoryQuantity: json["inventoryQuantity"],
        allowBackOrder: json["allowBackOrder"],
        manageInventory: json["manageInventory"],
        hsCode: json["hsCode"],
        originCountry: json["originCountry"],
        midCode: json["midCode"],
        material: json["material"],
        weight: json["weight"],
        height: json["height"],
        length: json["length"],
        width: json["width"],
        variantRank: json["variantRank"],
        price: json["price"],
        specialPrice: json["specialPrice"],
        specialPriceStartDate: json["specialPriceStartDate"],
        specialPriceEndDate: json["specialPriceEndDate"],
        inventory: json["inventory"],
        metadata: json["metadata"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        thumbnail: json["thumbnail"],
        createdById: json["createdById"],
        prices: json["prices"] == null
            ? []
            : List<dynamic>.from(json["prices"]!.map((x) => x)),
        originalPrice: json["originalPrice"],
        currentPrice: json["currentPrice"],
        salePrices: json["salePrices"] is! Map ? null : json["salePrices"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "title": title,
        "sku": sku,
        "barcode": barcode,
        "ean": ean,
        "upc": upc,
        "inventoryQuantity": inventoryQuantity,
        "allowBackOrder": allowBackOrder,
        "manageInventory": manageInventory,
        "hsCode": hsCode,
        "originCountry": originCountry,
        "midCode": midCode,
        "material": material,
        "weight": weight,
        "height": height,
        "length": length,
        "width": width,
        "variantRank": variantRank,
        "price": price,
        "specialPrice": specialPrice,
        "specialPriceStartDate": specialPriceStartDate,
        "specialPriceEndDate": specialPriceEndDate,
        "inventory": inventory,
        "metadata": metadata,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "thumbnail": thumbnail,
        "createdById": createdById,
        "prices":
            prices == null ? [] : List<dynamic>.from(prices!.map((x) => x)),
        "originalPrice": originalPrice,
        "currentPrice": currentPrice,
        "salePrices": salePrices,
      };
}

class Meta {
  int? total;
  int? items;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({
    this.total,
    this.items,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  Meta copyWith({
    int? total,
    int? items,
    int? perPage,
    int? currentPage,
    int? lastPage,
  }) =>
      Meta(
        total: total ?? this.total,
        items: items ?? this.items,
        perPage: perPage ?? this.perPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        items: json["items"],
        perPage: json["perPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "items": items,
        "perPage": perPage,
        "currentPage": currentPage,
        "lastPage": lastPage,
      };
}
