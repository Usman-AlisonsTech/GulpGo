class AllProductModel {
    AllProductModel({
        required this.products,
        required this.pagination,
    });

    final List<Product> products;
    final Pagination? pagination;

    factory AllProductModel.fromJson(Map<String, dynamic> json){ 
        return AllProductModel(
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "products": products.map((x) => x?.toJson()).toList(),
        "pagination": pagination?.toJson(),
    };

}

class Pagination {
    Pagination({
        required this.page,
        required this.limit,
        required this.total,
        required this.totalPages,
    });

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPages;

    factory Pagination.fromJson(Map<String, dynamic> json){ 
        return Pagination(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPages: json["totalPages"],
        );
    }

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPages": totalPages,
    };

}

class Product {
    Product({
        required this.id,
        required this.name,
        required this.size,
        required this.price,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.isReusable,
        required this.depositAmount,
        required this.requiresEmptyReturn,
        required this.user,
    });

    final String? id;
    final String? name;
    final String? size;
    final int? price;
    final String? image;
    final String? status;
    final DateTime? createdAt;
    final bool? isReusable;
    final int? depositAmount;
    final bool? requiresEmptyReturn;
    final User? user;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            name: json["name"],
            size: json["size"],
            price: json["price"],
            image: json["image"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            isReusable: json["isReusable"],
            depositAmount: json["depositAmount"],
            requiresEmptyReturn: json["requiresEmptyReturn"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "price": price,
        "image": image,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isReusable": isReusable,
        "depositAmount": depositAmount,
        "requiresEmptyReturn": requiresEmptyReturn,
        "user": user?.toJson(),
    };

}

class User {
    User({
        required this.name,
    });

    final String? name;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            name: json["name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
    };

}
