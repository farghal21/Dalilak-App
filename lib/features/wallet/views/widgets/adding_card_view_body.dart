import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../wallet_otp_view.dart';

class AddingCardViewBody extends StatelessWidget {
  const AddingCardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MyResponsive.height(value: 70),
            ),
            Text(
              AppStrings.selectChargeType,
              style: AppTextStyles.semiBold16,
            ),
            SizedBox(
              height: MyResponsive.height(value: 34),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.mastercardLogo,
                  width: MyResponsive.width(value: 95),
                  fit: BoxFit.fill,
                ),
              ],
            ),
            SizedBox(
              height: MyResponsive.height(value: 15),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CreditCardExampleScreen(),
            ),
            SizedBox(
              height: MyResponsive.height(value: 15),
            ),
            Padding(
              padding: MyResponsive.paddingSymmetric(horizontal: 15),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.wantAmountLabel,
                      hintText: AppStrings.wantAmountHint,
                      hintStyle: TextStyle(
                        color: AppColors.gray,
                      ),
                      suffix: Text(
                        AppStrings.rs,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MyResponsive.height(value: 40),
            ),
            CustomButton(
              title: AppStrings.next,
              onPressed: () {
                Navigator.pushNamed(context, WalletOtpView.routeName);
              },
            ),
            SizedBox(
              height: MyResponsive.height(value: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardExampleScreen extends StatefulWidget {
  const CreditCardExampleScreen({super.key});

  @override
  State<CreditCardExampleScreen> createState() =>
      _CreditCardExampleScreenState();
}

class _CreditCardExampleScreenState extends State<CreditCardExampleScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          isHolderNameVisible: true,
          showBackView: isCvvFocused,
          onCreditCardWidgetChange: (CreditCardBrand brand) {},
        ),
        CreditCardForm(
          formKey: formKey,
          inputConfiguration: InputConfiguration(
            cardNumberDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.cardNumberLabel,
              hintText: AppStrings.cardNumberHint,
              hintStyle: TextStyle(
                color: AppColors.gray,
              ),
            ),
            expiryDateDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.expiryDateLabel,
              hintText: AppStrings.expiryDateHint,
              hintStyle: TextStyle(
                color: AppColors.gray,
              ),
            ),
            cvvCodeDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.cvvLabel,
              hintText: AppStrings.cvvHint,
              hintStyle: TextStyle(
                color: AppColors.gray,
              ),
            ),
            cardHolderDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.cardHolderLabel,
              hintText: AppStrings.cardHolderHint,
              hintStyle: TextStyle(
                color: AppColors.gray,
              ),
            ),
          ),
          onCreditCardModelChange: (CreditCardModel data) {
            setState(() {
              cardNumber = data.cardNumber;
              expiryDate = data.expiryDate;
              cardHolderName = data.cardHolderName;
              cvvCode = data.cvvCode;
              isCvvFocused = data.isCvvFocused;
            });
          },
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
        ),
      ],
    );
  }
}
