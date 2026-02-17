import 'package:aqua_flow/models/customer_orders_model.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/views/dashboard/order_detail/widgets/order_detail_widget.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailView extends StatelessWidget {
  final Order orders;
  const OrderDetailView({super.key, required this.orders});

  Color _getStatusColor() {
    return orders.status == 'completed'
        ? const Color(0xFF22C55E)
        : orders.status == 'in_progress'
            ? Colors.grey
            : orders.status == 'pending'
                ? const Color(0xFFF59E0B)
                : orders.status == 'confirmed'
                    ? const Color(0xFF3B82F6)
                    : orders.status == 'out_for_delivery'
                        ? const Color(0xFF8B5CF6)
                        : orders.status == 'delivered'
                            ? const Color(0xFF10B981)
                            : orders.status == 'cancelled'
                                ? const Color(0xFFEF4444)
                                : orders.status == 'failed'
                                    ? const Color(0xFF991B1B)
                                    : orders.status == 'assigned'
                                        ? const Color(0xFF0EA5E9)
                                        : const Color(0xFFB45309);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusColor = _getStatusColor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        title: CustomText(
          text: 'Order Details',
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenConstants.horizontalPadding,
            vertical: ScreenConstants.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Number & Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 2,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Order Number',
                          fontSize: size.width * 0.035,
                          color: ColorConstants.darkGreyColor,
                        ),
                        SizedBox(height: size.height * 0.005),
                        CustomText(
                            text: orders.orderNumberDisplay ?? '-',
                            fontSize: size.width * 0.055,
                            weight: FontWeight.bold),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            text: orders.status ?? '',
                            fontSize: size.width * 0.035,
                            weight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Delivery Information Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 2,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          color: ColorConstants.themeColor,
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.03),
                        CustomText(
                          text: 'Delivery Information',
                          fontSize: size.width * 0.045,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    OrderDetailWidgets().buildInfoRow(
                      context,
                      Icons.calendar_today,
                      'Delivery Date',
                      HelperMethods()
                          .formatDate(orders.deliveryDate.toString()),
                      size,
                    ),
                    SizedBox(height: size.height * 0.015),
                    OrderDetailWidgets().buildInfoRow(
                      context,
                      Icons.location_on_outlined,
                      'Delivery Address',
                      orders.deliveryAddress ?? '-',
                      size,
                    ),
                    SizedBox(height: size.height * 0.015),
                    OrderDetailWidgets().buildInfoRow(
                      context,
                      Icons.map_outlined,
                      'Zone',
                      orders.zone?.name ?? '-',
                      size,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Order Items Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 2,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: ColorConstants.themeColor,
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.03),
                        CustomText(
                          text: 'Order Items',
                          fontSize: size.width * 0.045,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    ...orders.items.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.015),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.12,
                                  height: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.water_drop,
                                    color: ColorConstants.themeColor,
                                    size: size.width * 0.06,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.03),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: item.product?.name ?? '',
                                        fontSize: size.width * 0.04,
                                        weight: FontWeight.w600,
                                      ),
                                      SizedBox(height: size.height * 0.005),
                                      CustomText(
                                        text: 'Size: ${item.product?.size}',
                                        fontSize: size.width * 0.032,
                                        color: ColorConstants.darkGreyColor,
                                      ),
                                      SizedBox(height: size.height * 0.005),
                                      CustomText(
                                        text: 'Quantity: ${item.quantity}',
                                        fontSize: size.width * 0.032,
                                        color: ColorConstants.darkGreyColor,
                                      ),
                                    ],
                                  ),
                                ),
                                CustomText(
                                  text:
                                      'Rs ${HelperMethods().formatNumber(item.totalPrice)}',
                                  fontSize: size.width * 0.042,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Payment Details Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 2,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.payment_outlined,
                          color: ColorConstants.themeColor,
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.03),
                        CustomText(
                          text: 'Payment Details',
                          fontSize: size.width * 0.045,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    OrderDetailWidgets().buildPaymentRow(
                      'Payment Method',
                      orders.paymentMethod!.replaceAll('_', ' ').toUpperCase(),
                      size,
                      false,
                    ),
                    if(orders.totalDeposit! > 0)...[
                    Divider(height: size.height * 0.03),
                    OrderDetailWidgets().buildPaymentRow(
                      'Total Deposit',
                      'Rs ${HelperMethods().formatNumber(orders.totalDeposit??0)}',
                      size,
                      false,
                    ),
                    ],
                    Divider(height: size.height * 0.03),
                    OrderDetailWidgets().buildPaymentRow(
                      'Total Amount',
                      'Rs ${HelperMethods().formatNumber(orders.totalAmount)}',
                      size,
                      false,
                    ),       
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
