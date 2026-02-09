class OrderPaymentModel {
    OrderPaymentModel({
        required this.success,
        required this.payments,
        required this.summary,
    });

    final bool? success;
    final List<Payment> payments;
    final Summary? summary;

    factory OrderPaymentModel.fromJson(Map<String, dynamic> json){ 
        return OrderPaymentModel(
            success: json["success"],
            payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
            summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "payments": payments.map((x) => x?.toJson()).toList(),
        "summary": summary?.toJson(),
    };

}

class Payment {
    Payment({
        required this.id,
        required this.paymentNumber,
        required this.customerId,
        required this.tenantId,
        required this.orderId,
        required this.subscriptionId,
        required this.amount,
        required this.paidAmount,
        required this.pendingAmount,
        required this.collectionType,
        required this.dueDate,
        required this.paymentDate,
        required this.status,
        required this.paymentMethod,
        required this.month,
        required this.year,
        required this.cycleStartDate,
        required this.cycleEndDate,
        required this.collectedByDriverId,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
        required this.order,
        required this.subscription,
        required this.collectedByDriver,
        required this.paymentItems,
    });

    final String? id;
    final String? paymentNumber;
    final String? customerId;
    final String? tenantId;
    final String? orderId;
    final dynamic subscriptionId;
    final int? amount;
    final int? paidAmount;
    final int? pendingAmount;
    final String? collectionType;
    final DateTime? dueDate;
    final DateTime? paymentDate;
    final String? status;
    final String? paymentMethod;
    final dynamic month;
    final dynamic year;
    final dynamic cycleStartDate;
    final dynamic cycleEndDate;
    final String? collectedByDriverId;
    final dynamic notes;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Order? order;
    final dynamic subscription;
    final CollectedByDriver? collectedByDriver;
    final List<PaymentItem> paymentItems;

    factory Payment.fromJson(Map<String, dynamic> json){ 
        return Payment(
            id: json["id"],
            paymentNumber: json["paymentNumber"],
            customerId: json["customerId"],
            tenantId: json["tenantId"],
            orderId: json["orderId"],
            subscriptionId: json["subscriptionId"],
            amount: json["amount"],
            paidAmount: json["paidAmount"],
            pendingAmount: json["pendingAmount"],
            collectionType: json["collectionType"],
            dueDate: DateTime.tryParse(json["dueDate"] ?? ""),
            paymentDate: DateTime.tryParse(json["paymentDate"] ?? ""),
            status: json["status"],
            paymentMethod: json["paymentMethod"],
            month: json["month"],
            year: json["year"],
            cycleStartDate: json["cycleStartDate"],
            cycleEndDate: json["cycleEndDate"],
            collectedByDriverId: json["collectedByDriverId"],
            notes: json["notes"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            order: json["order"] == null ? null : Order.fromJson(json["order"]),
            subscription: json["subscription"],
            collectedByDriver: json["collectedByDriver"] == null ? null : CollectedByDriver.fromJson(json["collectedByDriver"]),
            paymentItems: json["paymentItems"] == null ? [] : List<PaymentItem>.from(json["paymentItems"]!.map((x) => PaymentItem.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "paymentNumber": paymentNumber,
        "customerId": customerId,
        "tenantId": tenantId,
        "orderId": orderId,
        "subscriptionId": subscriptionId,
        "amount": amount,
        "paidAmount": paidAmount,
        "pendingAmount": pendingAmount,
        "collectionType": collectionType,
        "dueDate": dueDate?.toIso8601String(),
        "paymentDate": paymentDate?.toIso8601String(),
        "status": status,
        "paymentMethod": paymentMethod,
        "month": month,
        "year": year,
        "cycleStartDate": cycleStartDate,
        "cycleEndDate": cycleEndDate,
        "collectedByDriverId": collectedByDriverId,
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "order": order?.toJson(),
        "subscription": subscription,
        "collectedByDriver": collectedByDriver?.toJson(),
        "paymentItems": paymentItems.map((x) => x?.toJson()).toList(),
    };

}

class CollectedByDriver {
    CollectedByDriver({
        required this.name,
        required this.phone,
    });

    final String? name;
    final String? phone;

    factory CollectedByDriver.fromJson(Map<String, dynamic> json){ 
        return CollectedByDriver(
            name: json["name"],
            phone: json["phone"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
    };

}

class Order {
    Order({
        required this.orderNumberDisplay,
        required this.deliveryDate,
    });

    final String? orderNumberDisplay;
    final DateTime? deliveryDate;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            orderNumberDisplay: json["orderNumberDisplay"],
            deliveryDate: DateTime.tryParse(json["deliveryDate"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "orderNumberDisplay": orderNumberDisplay,
        "deliveryDate": deliveryDate?.toIso8601String(),
    };

}

class PaymentItem {
    PaymentItem({
        required this.productName,
        required this.quantity,
        required this.totalAmount,
    });

    final String? productName;
    final int? quantity;
    final int? totalAmount;

    factory PaymentItem.fromJson(Map<String, dynamic> json){ 
        return PaymentItem(
            productName: json["productName"],
            quantity: json["quantity"],
            totalAmount: json["totalAmount"],
        );
    }

    Map<String, dynamic> toJson() => {
        "productName": productName,
        "quantity": quantity,
        "totalAmount": totalAmount,
    };

}

class Summary {
    Summary({
        required this.totalAmount,
        required this.totalPaid,
        required this.totalPending,
    });

    final int? totalAmount;
    final int? totalPaid;
    final int? totalPending;

    factory Summary.fromJson(Map<String, dynamic> json){ 
        return Summary(
            totalAmount: json["totalAmount"],
            totalPaid: json["totalPaid"],
            totalPending: json["totalPending"],
        );
    }

    Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "totalPaid": totalPaid,
        "totalPending": totalPending,
    };

}
