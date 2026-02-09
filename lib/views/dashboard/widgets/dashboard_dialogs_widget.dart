import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/dashboard/dashboard_controller.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRecurringOrderDialog extends StatefulWidget {
  final int quantity;
  final String deliveryDate;
  final String orderId;
  final bool skipThisWeek;

  const EditRecurringOrderDialog({
    super.key,
    required this.quantity,
    required this.deliveryDate,
    required this.orderId,
    required this.skipThisWeek,
  });

  @override
  State<EditRecurringOrderDialog> createState() =>
      _EditRecurringOrderDialogState();
}

class _EditRecurringOrderDialogState extends State<EditRecurringOrderDialog> {
  final controller = Get.find<DashboardController>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool skipThisWeek = false;

  @override
  void initState() {
    super.initState();

    quantityController.text = widget.quantity.toString();
    dateController.text = widget.deliveryDate;
    skipThisWeek = widget.skipThisWeek;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Dialog Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Edit Recurring Order',
                    fontSize: 18,
                    weight: FontWeight.w700,
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 16),

              /// Quantity
              CustomText(
                  text: 'Quantity', fontSize: 14, weight: FontWeight.w600),
              const SizedBox(height: 6),
              CustomTextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                hintText: 'Enter quantity',
              ),
              const SizedBox(height: 10),

              /// Delivery Date
              // CustomText(
              //     text: 'Delivery Date', fontSize: 14, weight: FontWeight.w600),
              // const SizedBox(height: 6),
              // CustomTextField(
              //   controller: dateController,
              //   readOnly: true,
              //   hintText: 'Select delivery date',
              //   suffixIcon: GestureDetector(
              //       onTap: () async {
              //         DateTime? picked = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime.now(),
              //           lastDate: DateTime.now().add(const Duration(days: 365)),
              //         );
              //         if (picked != null) {
              //           dateController.text = HelperMethods()
              //               .formatDate(picked.toIso8601String());
              //         }
              //       },
              //       child: Padding(
              //         padding: EdgeInsets.all(8),
              //         child: Icon(Icons.calendar_month),
              //       )),
              // ),
              // const SizedBox(height: 10),

              /// Skip This Week
              Row(
                children: [
                  Checkbox(
                    value: skipThisWeek,
                    onChanged: (val) {
                      setState(() {
                        skipThisWeek = val ?? false;
                      });
                    },
                    activeColor: ColorConstants.themeColor,
                  ),
                  CustomText(
                    text: 'Skip this week',
                    fontSize: 14,
                    weight: FontWeight.w500,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Obx(
                () => CommonButton(
                  title: 'Save',
                  verticalPadding: 8,
                  isLoading: controller.isRecurringSubscription.value,
                  onPressed: () {
                    final data = {
                      "quantity": int.tryParse(quantityController.text) ?? 0,
                      // "deliveryDate": dateController.text,
                      "skipThisWeek": skipThisWeek,
                    };
                    print(data);
                    controller.editRecurringOrder(
                        data, widget.orderId, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnsubscribeDialog extends StatelessWidget {
  final bool isActive;
  final BuildContext context;
  final String subscriptionId;

  const UnsubscribeDialog(
      {super.key,
      required this.isActive,
      required this.context,
      required this.subscriptionId});

  @override
  Widget build(BuildContext context) {
    print('Usman Recurring print: ${isActive}');
    final controller = Get.find<DashboardController>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: isActive
                  ? 'Are you sure you want to unsubscribe?'
                  : 'Are you sure you want to subscribe?',
              fontSize: 16,
              weight: FontWeight.w600,
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// No button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: CustomText(
                      text: 'No',
                      fontSize: 14,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                /// Yes button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.recurringSubscription({
                        "action": isActive ? "PAUSE" : "RESUME",
                      }, subscriptionId, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: CustomText(
                      text: 'Yes',
                      fontSize: 14,
                      color: Colors.white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
