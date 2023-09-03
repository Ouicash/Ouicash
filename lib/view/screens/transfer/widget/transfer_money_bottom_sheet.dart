import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Ouiacsh_app/core/helper/string_format_helper.dart';
import 'package:Ouiacsh_app/core/utils/dimensions.dart';
import 'package:Ouiacsh_app/core/utils/my_strings.dart';
import 'package:Ouiacsh_app/data/controller/transfer/transfer_money_controller.dart';
import 'package:Ouiacsh_app/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:Ouiacsh_app/view/components/buttons/rounded_button.dart';
import 'package:Ouiacsh_app/view/components/buttons/rounded_loading_button.dart';
import 'package:Ouiacsh_app/view/components/divider/custom_divider.dart';
import 'package:Ouiacsh_app/view/components/row_widget/bottom_sheet_row.dart';

class TransferMoneyBottomSheet extends StatelessWidget {
  const TransferMoneyBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferMoneyController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetHeaderRow(header: MyStrings.paymentPreview,),
          const SizedBox(height: 20,),
          BottomSheetRow(
            header: MyStrings.totalAmount,
            body: "${Converter.formatNumber(controller.amountController.text,precision: controller.selectedWallet?.currency?.currencyType=='2'?8:2)} ${controller.currency}",
          ),
          const SizedBox(height: Dimensions.space10),
          BottomSheetRow(
            header: MyStrings.totalCharge,
            body: controller.charge,
          ),
          const CustomDivider(space: 15,),
          BottomSheetRow(
            header: MyStrings.payable,
            body: controller.payableText,
          ),
          const SizedBox(height: Dimensions.space30),
          controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
            text: MyStrings.confirm,
            press: (){
                controller.submitTransferMoney();
              }
          )
        ],
      ),
    );
  }
}
