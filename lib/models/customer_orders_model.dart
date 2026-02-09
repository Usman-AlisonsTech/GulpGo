class CustomerOrdersModel {
    CustomerOrdersModel({
        required this.success,
        required this.orders,
        required this.pagination,
    });

    final bool? success;
    final List<Order> orders;
    final Pagination? pagination;

    factory CustomerOrdersModel.fromJson(Map<String, dynamic> json){ 
        return CustomerOrdersModel(
            success: json["success"],
            orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "orders": orders.map((x) => x?.toJson()).toList(),
        "pagination": pagination?.toJson(),
    };

}

class Order {
    Order({
        required this.id,
        required this.orderNumber,
        required this.orderNumberDisplay,
        required this.customerId,
        required this.driverId,
        required this.zoneId,
        required this.deliveryDate,
        required this.deliveryAddress,
        required this.totalAmount,
        required this.paymentMethod,
        required this.status,
        required this.tenantId,
        required this.createdById,
        required this.createdAt,
        required this.updatedAt,
        required this.acceptableDepositAmount,
        required this.scheduledDate,
        required this.isRecurring,
        required this.nextRecurringDate,
        required this.notificationSent,
        required this.recurrence,
        required this.subscriptionId,
        required this.withBottles,
        required this.paidAmount,
        required this.paymentId,
        required this.paymentStatus,
        required this.driver,
        required this.zone,
        required this.items,
        required this.subscription,
        required this.showBottlesInfo,
        required this.totalDeposit,
    });

    final String? id;
    final int? orderNumber;
    final String? orderNumberDisplay;
    final String? customerId;
    final dynamic driverId;
    final String? zoneId;
    final DateTime? deliveryDate;
    final String? deliveryAddress;
    final int? totalAmount;
    final String? paymentMethod;
    final String? status;
    final String? tenantId;
    final dynamic createdById;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? acceptableDepositAmount;
    final dynamic scheduledDate;
    final bool? isRecurring;
    final dynamic nextRecurringDate;
    final bool? notificationSent;
    final String? recurrence;
    final dynamic subscriptionId;
    final bool? withBottles;
    final int? paidAmount;
    final dynamic paymentId;
    final String? paymentStatus;
    final dynamic driver;
    final Zone? zone;
    final List<Item> items;
    final dynamic subscription;
    final bool? showBottlesInfo;
    final int? totalDeposit;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            id: json["id"],
            orderNumber: json["orderNumber"],
            orderNumberDisplay: json["orderNumberDisplay"],
            customerId: json["customerId"],
            driverId: json["driverId"],
            zoneId: json["zoneId"],
            deliveryDate: DateTime.tryParse(json["deliveryDate"] ?? ""),
            deliveryAddress: json["deliveryAddress"],
            totalAmount: json["totalAmount"],
            paymentMethod: json["paymentMethod"],
            status: json["status"],
            tenantId: json["tenantId"],
            createdById: json["createdById"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            acceptableDepositAmount: json["acceptableDepositAmount"],
            scheduledDate: json["scheduledDate"],
            isRecurring: json["isRecurring"],
            nextRecurringDate: json["nextRecurringDate"],
            notificationSent: json["notificationSent"],
            recurrence: json["recurrence"],
            subscriptionId: json["subscriptionId"],
            withBottles: json["withBottles"],
            paidAmount: json["paidAmount"],
            paymentId: json["paymentId"],
            paymentStatus: json["paymentStatus"],
            driver: json["driver"],
            zone: json["zone"] == null ? null : Zone.fromJson(json["zone"]),
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
            subscription: json["subscription"],
            showBottlesInfo: json["showBottlesInfo"],
            totalDeposit: json["totalDeposit"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "orderNumberDisplay": orderNumberDisplay,
        "customerId": customerId,
        "driverId": driverId,
        "zoneId": zoneId,
        "deliveryDate": deliveryDate?.toIso8601String(),
        "deliveryAddress": deliveryAddress,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "status": status,
        "tenantId": tenantId,
        "createdById": createdById,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "acceptableDepositAmount": acceptableDepositAmount,
        "scheduledDate": scheduledDate,
        "isRecurring": isRecurring,
        "nextRecurringDate": nextRecurringDate,
        "notificationSent": notificationSent,
        "recurrence": recurrence,
        "subscriptionId": subscriptionId,
        "withBottles": withBottles,
        "paidAmount": paidAmount,
        "paymentId": paymentId,
        "paymentStatus": paymentStatus,
        "driver": driver,
        "zone": zone?.toJson(),
        "items": items.map((x) => x?.toJson()).toList(),
        "subscription": subscription,
        "showBottlesInfo": showBottlesInfo,
        "totalDeposit": totalDeposit,
    };

}

class Item {
    Item({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
        required this.unitPrice,
        required this.totalPrice,
        required this.depositAmount,
        required this.product,
    });

    final String? id;
    final String? orderId;
    final String? productId;
    final int? quantity;
    final int? unitPrice;
    final int? totalPrice;
    final int? depositAmount;
    final Product? product;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            id: json["id"],
            orderId: json["orderId"],
            productId: json["productId"],
            quantity: json["quantity"],
            unitPrice: json["unitPrice"],
            totalPrice: json["totalPrice"],
            depositAmount: json["depositAmount"],
            product: json["product"] == null ? null : Product.fromJson(json["product"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "totalPrice": totalPrice,
        "depositAmount": depositAmount,
        "product": product?.toJson(),
    };

}

class Product {
    Product({
        required this.id,
        required this.name,
        required this.size,
        required this.price,
        required this.isReusable,
        required this.depositAmount,
    });

    final String? id;
    final String? name;
    final String? size;
    final int? price;
    final bool? isReusable;
    final int? depositAmount;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            name: json["name"],
            size: json["size"],
            price: json["price"],
            isReusable: json["isReusable"],
            depositAmount: json["depositAmount"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "price": price,
        "isReusable": isReusable,
        "depositAmount": depositAmount,
    };

}

class Zone {
    Zone({
        required this.name,
    });

    final String? name;

    factory Zone.fromJson(Map<String, dynamic> json){ 
        return Zone(
            name: json["name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
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
