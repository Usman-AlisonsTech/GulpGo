import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:get/get.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int currentStep = 1;

  void nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    }
  }

  void backStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  Widget stepCircle(int step, String label) {
    bool isActive = step == currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? ColorConstants.themeColor : Colors.grey[300],
          child: CustomText(
            text: step.toString(),
            fontSize: 14,
            weight: FontWeight.w500,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 4),
        CustomText(
          text: label,
          fontSize: 12,
          weight: FontWeight.w500,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget stepDivider() {
    return Expanded(
      child: Divider(
        color: Colors.grey[300],
        thickness: 2,
      ),
    );
  }

  Widget getStepUi() {
    switch (currentStep) {
      case 1:
        return FirstStepUi();
      case 2:
        return SecondStepUi();
      case 3:
        return ThirdStepUi();
      case 4:
        return FourthStepUi();  
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenConstants.horizontalPadding,
            vertical: ScreenConstants.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Request Water',
                fontSize: 18,
                weight: FontWeight.w500,
              ),
              CustomText(
                text: 'Place your order',
                fontSize: 13,
                color: Color(0xff4A4A4A),
                weight: FontWeight.w500,
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Divider(color: Color(0xffD1D4D9)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  stepCircle(1, 'Bottles'),
                  stepDivider(),
                  stepCircle(2, 'Schedule'),
                  stepDivider(),
                  stepCircle(3, 'Confirm'),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Divider(color: Color(0xffD1D4D9)),
              ),
              // Step-specific UI
              Expanded(child: SingleChildScrollView(child: getStepUi())),
              if(currentStep !=4)
              SizedBox(height: 10),
              // Buttons
              if(currentStep !=4)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep != 1)
                    Expanded(
                      child: CommonButton(
                        title: 'Back',
                        onPressed: backStep,
                        bgColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: ColorConstants.greyColor,
                        verticalPadding: 8,
                      ),
                    ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      title: currentStep == 3 ? 'Place Order' : currentStep ==1 ? 'Continue to Schedule' : 'Next',
                      onPressed: currentStep == 4 ? () {} : nextStep,
                      verticalPadding: 8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Step Widgets -------------------

class FirstStepUi extends StatefulWidget {
  const FirstStepUi({super.key});

  @override
  State<FirstStepUi> createState() => _FirstStepUiState();
}

class _FirstStepUiState extends State<FirstStepUi> {
  int bottle20L = 0;
  int bottle10L = 0;
  int bottle5L = 0;

  double get subtotal {
    return (bottle20L * 12.00) + (bottle10L * 8.00) + (bottle5L * 5.00);
  }

  double get total => subtotal + 3.00;

  void updateQuantity(int change, int current, Function(int) setter) {
    final newValue = (current + change).clamp(0, 99);
    setState(() {
      setter(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          const CustomText(
            text: "Select Bottle Size & Quantity",
            fontSize: 17,
             weight: FontWeight.w500,
          ),
          const SizedBox(height: 20),

          // 20L Bottle
          _buildBottleRow(
            size: "20L Bottle",
            price: "\$12.00 each",
            quantity: bottle20L,
            onDecrease: () => updateQuantity(-1, bottle20L, (v) => bottle20L = v),
            onIncrease: () => updateQuantity(1, bottle20L, (v) => bottle20L = v),
          ),
          const SizedBox(height: 12),

          // 10L Bottle
          _buildBottleRow(
            size: "10L Bottle",
            price: "\$8.00 each",
            quantity: bottle10L,
            onDecrease: () => updateQuantity(-1, bottle10L, (v) => bottle10L = v),
            onIncrease: () => updateQuantity(1, bottle10L, (v) => bottle10L = v),
          ),
          const SizedBox(height: 12),

          // 5L Bottle
          _buildBottleRow(
            size: "5L Bottle",
            price: "\$5.00 each",
            quantity: bottle5L,
            onDecrease: () => updateQuantity(-1, bottle5L, (v) => bottle5L = v),
            onIncrease: () => updateQuantity(1, bottle5L, (v) => bottle5L = v),
          ),

          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffEFF6FF),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
          // Subtotal
          _buildPriceRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),

          const SizedBox(height: 20),

          // Delivery Fee
          _buildPriceRow("Delivery Fee", "\$3.00"),

          const SizedBox(height: 20),
          const Divider(height: 1, thickness: 1),

          const SizedBox(height: 20),

          // Total
          _buildPriceRow("Total", "\$${total.toStringAsFixed(2)}", isTotal: true),
              ],
            ),
          )
        ],
      );
  }

  Widget _buildBottleRow({
    required String size,
    required String price,
    required int quantity,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Row(
        children: [
          // Water Drop Icon
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              shape: BoxShape.circle,
            ),
            child:  Icon(
              Icons.water_drop,
              color: ColorConstants.themeColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Size & Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: size,
                  fontSize: 15,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: price,
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              InkWell(
                onTap: quantity > 0 ? onDecrease : null,
                child: CircleAvatar(
                          radius: 15,
                          backgroundColor:ColorConstants.lightGrey,
                          child: Icon(Icons.remove, size: 20,),
                        ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: "$quantity",
                  fontSize: 15,
                  weight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: onIncrease,
                child: CircleAvatar(
                          radius: 15,
                          backgroundColor: ColorConstants.themeColor,
                          child: Icon(Icons.add, color: Colors.white,size: 20,),
                        ),)
             
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: isTotal ? 15 : 16,
        ),
        CustomText(
          text: amount,
          fontSize: isTotal ? 20 : 16,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}

class SecondStepUi extends StatefulWidget {
  const SecondStepUi({super.key});

  @override
  State<SecondStepUi> createState() => _SecondStepUiState();
}

class _SecondStepUiState extends State<SecondStepUi> {
  int? selectedTimeSlot; // null = none selected

  final List<Map<String, dynamic>> timeSlots = [
    {
      'range': '10:00 AM - 12:00 PM',
      'available': true,
    },
    {
      'range': '12:00 PM - 2:00 PM',
      'available': false,
    },
    {
      'range': '2:00 PM - 4:00 PM',
      'available': true,
    },
    {
      'range': '4:00 PM - 6:00 PM',
      'available': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 20),
          const CustomText(
            text: "Select Delivery Time",
            fontSize: 17,
             weight: FontWeight.w500,
          ),
          const SizedBox(height: 15),

          // Delivery Date
          CustomText(
            text: "Delivery Date",
            fontSize: 16,
            weight: FontWeight.w500,
            color: ColorConstants.darkGreyColor,
          ),
          const SizedBox(height: 12),

          _buildDateCard(),
          const SizedBox(height: 25),

          // Time Slot Label
          CustomText(
            text: "Time Slot",
            fontSize: 16,
            weight: FontWeight.w500,
            color: ColorConstants.darkGreyColor,
          ),
          const SizedBox(height: 12),

          // Time Slots
          ...timeSlots.asMap().entries.map((entry) {
            final index = entry.key;
            final slot = entry.value;
            final isSelected = selectedTimeSlot == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildTimeSlotTile(
                range: slot['range'],
                available: slot['available'],
                isSelected: isSelected,
                onTap: slot['available']
                    ? () {
                        setState(() {
                          selectedTimeSlot = isSelected ? null : index;
                        });
                      }
                    : null,
              ),
            );
          }).toList(),
        ],
      );
  }

  Widget _buildDateCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Row(
        children: [
           Icon(
            Icons.calendar_today,
            color: ColorConstants.themeColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Today",
                  fontSize: 16,
                ),
                CustomText(
                  text: "November 4, 2025",
                  fontSize: 14,
                  color: ColorConstants.darkGreyColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotTile({
    required String range,
    required bool available,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    final bool isDisabled = !available;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isDisabled ? const Color(0xFFF5F5F5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : ColorConstants.lightGrey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Radio / Dot Indicator
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDisabled
                      ? Colors.grey[400]!
                      : isSelected
                          ? Colors.blue
                          : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.circle,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            // Clock Icon
            Icon(
              Icons.access_time,
              size: 18,
              color: isDisabled ? Colors.grey[500] : Colors.blue,
            ),
            const SizedBox(width: 12),

            // Time Range
            Expanded(
              child: CustomText(
                text: range,
                fontSize: 15,
                color: isDisabled ? ColorConstants.lightGrey : Colors.black,
              ),
            ),

            // Not Available Text
            if (!available)
              CustomText(
                text: "Not available",
                fontSize: 11,
                color: ColorConstants.redColor,
              ),
          ],
        ),
      ),
    );
  }
}

class ThirdStepUi extends StatefulWidget {
  const ThirdStepUi({super.key});

  @override
  State<ThirdStepUi> createState() => _ThirdStepUiState();
}

class _ThirdStepUiState extends State<ThirdStepUi> {
  int? selectedPaymentMethod;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'method': 'Cash on Delivery',
      'description': 'Pay when you recieve',
    },
    {
      'method': 'Credit/Debit Card',
      'description': 'Vise/ Mastercard',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          SizedBox(height: 20),
          const CustomText(
            text: "Confirm Order",
            fontSize: 17,
             weight: FontWeight.w500,
          ),
          const SizedBox(height: 20),
           // Time Slots
            //  ...paymentMethods.asMap().entries.map((entry) {
            //     final index = entry.key;
            //     final slot = entry.value;
            //     final isSelected = selectedPaymentMethod == index;

            //     return Padding(
            //       padding: const EdgeInsets.only(bottom: 12),
            //       child: _buildPaymentMethods(
            //         method: slot['method'],
            //         description: slot['description'],
            //         isSelected: isSelected,
            //         icon: index == 0? Icons.payments:Icons.credit_card_outlined,
            //         onTap: () {
            //           setState(() {
            //             selectedPaymentMethod =
            //                 isSelected ? null : index;
            //           });
            //         },
            //       ),
            //     );
            //   }).toList(),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffEFF6FF),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
          // Subtotal
          _buildPriceRow("Order Summary", ""),

          const SizedBox(height: 20),

          // Delivery Fee
          _buildPriceRow("20x 20L Bottle", "\$3.00", isOrderedList: true),

          const SizedBox(height: 20),
          const Divider(height: 1, thickness: 1),

          const SizedBox(height: 20),
          // Total
          _buildPriceRow("Total Amount", "1212", isTotal: true),
              ],
            ),
          )
      ],
    );  
  }

 Widget _buildPaymentMethods({
    required String method,
    required String description,
    required bool isSelected,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : const Color(0xffE0E0E0),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Radio dot
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.circle, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),

            // Money icon
            Icon(icon, size: 18, color: Colors.blue),
            const SizedBox(width: 12),

            // Method name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: method,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  CustomText(text: description, color: ColorConstants.darkGreyColor,fontSize: 12,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildPriceRow(String label, String amount, {bool isTotal = false, bool isOrderedList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: isTotal ? 15 : isOrderedList? 13: 16,
        ),
        CustomText(
          text: amount,
          fontSize: isTotal ? 20 :isOrderedList? 13: 16,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}

class FourthStepUi extends StatelessWidget {
  const FourthStepUi({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xffDBFCE7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xff00C951),
              size: 40,
            ),
          ),
          const SizedBox(height: 20),

          // Title
           CustomText(
            text: "Order Placed Successfully!",
            fontSize: 18,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),

          // Subtitle
          CustomText(
            text: "Your order #5678 has been confirmed",
            fontSize: 14,
            color: ColorConstants.darkGreyColor,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Summary Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstants.lightGrey)
            ),
            child: Column(
              children: const [
                _SummaryRow(label: "Delivery Date", value: "Today"),
                _SummaryRow(label: "Time Slot", value: "2:00 PM - 4:00 PM"),
                _SummaryRow(label: "Payment", value: "Cash on Delivery"),
                _SummaryRow(
                  label: "Total Amount",
                  value: "\$27.00",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Back to Home Button
          CommonButton(
            title: 'Back to Home',
            onPressed: () {Get.offAll(BottomNavigation(index: 0));},
            textColor: Colors.white,
            verticalPadding: 8,
          ),
        ],
      );
  }
}

// Reusable row for summary
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: label,
              fontSize: 13,
              color: ColorConstants.darkGreyColor,
            ),
            CustomText(
              text: value,
              fontSize: 13,
            ),
          ],
        ),
    );
  }
}