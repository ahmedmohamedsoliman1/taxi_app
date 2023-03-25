import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../config/fireBase_funs.dart';
import '../../../../core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import '../../data/models/card_model.dart';


class AddNewCardScreen extends StatefulWidget {

  static const String routeName = "add_card" ;
  @override
  State<StatefulWidget> createState() {
    return AddNewCardScreenState();
  }
}

class AddNewCardScreenState extends State<AddNewCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack (
          children: [
            Container(color: Colors.white,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration (
                  image: DecorationImage (
                      image: AssetImage ("assets/images/Background_credit.png"),
                      fit: BoxFit.fill
                  )
              ),
            ) ,
            Positioned(
              top: 80,
              left: 50,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back , color: AppColors.primaryColor,)),
                        ),
                        SizedBox(width: 20,),
                        textWidget (text: "Add new card" , color: Colors.white , fontSize: 22 ,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      CreditCardWidget(
                        glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        bankName: 'Flutter Bank',
                        frontCardBorder:
                        !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                        backCardBorder:
                        !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        isSwipeGestureEnabled: true,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              CreditCardForm(
                                formKey: formKey,
                                obscureCvv: true,
                                obscureNumber: true,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: Colors.white,
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                ),
                                expiryDateDecoration: InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Card Holder',
                                ),
                                onCreditCardModelChange: onCreditCardModelChange,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(onPressed:(){
                                  _onValidate();
                              }, child: Text ("Save" , style: TextStyle(
                                fontSize: 18 , fontWeight: FontWeight.bold
                              ),) , style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      );
  }

  void _onValidate() async {
    if (formKey.currentState.validate()) {
      CardModel cardModel = CardModel(cvv: cvvCode , expired: expiryDate , holder: cardHolderName ,
      number: cardNumber);
      print('valid!');
     var newCard =  await FireBaseFuns.addCardToFireBase(cardModel).then((value) =>{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your card saved successfully")))
     });
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}