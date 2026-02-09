class RecurringUpcomingModel {
    RecurringUpcomingModel({
        required this.success,
        required this.orders,
        required this.total,
    });

    final bool? success;
    final List<Order> orders;
    final int? total;

    factory RecurringUpcomingModel.fromJson(Map<String, dynamic> json){ 
        return RecurringUpcomingModel(
            success: json["success"],
            orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "orders": orders.map((x) => x?.toJson()).toList(),
        "total": total,
    };

}

class Order {
    Order({
        required this.id,
        required this.orderNumber,
        required this.deliveryDate,
        required this.status,
        required this.items,
        required this.subscription,
        required this.canEdit,
        required this.editDeadline,
    });

    final String? id;
    final String? orderNumber;
    final DateTime? deliveryDate;
    final String? status;
    final List<Item> items;
    final Subscription? subscription;
    final bool? canEdit;
    final DateTime? editDeadline;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            id: json["id"],
            orderNumber: json["orderNumber"],
            deliveryDate: DateTime.tryParse(json["deliveryDate"] ?? ""),
            status: json["status"],
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
            subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
            canEdit: json["canEdit"],
            editDeadline: DateTime.tryParse(json["editDeadline"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "deliveryDate": deliveryDate?.toIso8601String(),
        "status": status,
        "items": items.map((x) => x?.toJson()).toList(),
        "subscription": subscription?.toJson(),
        "canEdit": canEdit,
        "editDeadline": editDeadline?.toIso8601String(),
    };

}

class Item {
    Item({
        required this.product,
        required this.quantity,
        required this.price,
        required this.total,
    });

    final String? product;
    final int? quantity;
    final int? price;
    final int? total;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            product: json["product"],
            quantity: json["quantity"],
            price: json["price"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "price": price,
        "total": total,
    };

}

class Subscription {
    Subscription({
        required this.id,
        required this.status,
        required this.recurrence,
        required this.nextDelivery,
        required this.totalDeliveries,
    });

    final String? id;
    final String? status;
    final String? recurrence;
    final DateTime? nextDelivery;
    final int? totalDeliveries;

    factory Subscription.fromJson(Map<String, dynamic> json){ 
        return Subscription(
            id: json["id"],
            status: json["status"],
            recurrence: json["recurrence"],
            nextDelivery: DateTime.tryParse(json["nextDelivery"] ?? ""),
            totalDeliveries: json["totalDeliveries"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "recurrence": recurrence,
        "nextDelivery": nextDelivery?.toIso8601String(),
        "totalDeliveries": totalDeliveries,
    };

}
