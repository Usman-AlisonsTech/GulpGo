class CustomerBottleInfoModel {
    CustomerBottleInfoModel({
        required this.success,
        required this.bottlesInfo,
    });

    final bool? success;
    final BottlesInfo? bottlesInfo;

    factory CustomerBottleInfoModel.fromJson(Map<String, dynamic> json){ 
        return CustomerBottleInfoModel(
            success: json["success"],
            bottlesInfo: json["bottlesInfo"] == null ? null : BottlesInfo.fromJson(json["bottlesInfo"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "bottlesInfo": bottlesInfo?.toJson(),
    };

}

class BottlesInfo {
    BottlesInfo({
        required this.emptiesAvailable,
        required this.totalBottlesGiven,
        required this.securityDeposit,
        required this.canOrderWithoutBottles,
        required this.message,
    });

    final int? emptiesAvailable;
    final int? totalBottlesGiven;
    final int? securityDeposit;
    final bool? canOrderWithoutBottles;
    final String? message;

    factory BottlesInfo.fromJson(Map<String, dynamic> json){ 
        return BottlesInfo(
            emptiesAvailable: json["emptiesAvailable"],
            totalBottlesGiven: json["totalBottlesGiven"],
            securityDeposit: json["securityDeposit"],
            canOrderWithoutBottles: json["canOrderWithoutBottles"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "emptiesAvailable": emptiesAvailable,
        "totalBottlesGiven": totalBottlesGiven,
        "securityDeposit": securityDeposit,
        "canOrderWithoutBottles": canOrderWithoutBottles,
        "message": message,
    };

}
