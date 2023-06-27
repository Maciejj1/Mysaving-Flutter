import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/pages/main_page/main_page.dart';

class MySavingTutorial extends StatefulWidget {
  const MySavingTutorial({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MySavingTutorial());
  }

  @override
  State<MySavingTutorial> createState() => _MySavingTutorialState();
}

class _MySavingTutorialState extends State<MySavingTutorial> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/tutorials/$assetName', width: width);
  }

  static const bodyStyle = TextStyle(fontSize: 17.0, color: Color(0xff4D5284));
  static var pageDecoration = PageDecoration(
    bodyFlex: 4,
    imageFlex: 6,

    titlePadding: EdgeInsets.fromLTRB(
        16.0, 30, 16.0, 20), // Zmniejszono górną i dolną wartość
    titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: MySavingColors.defaultDarkText),
    bodyTextStyle: bodyStyle,
    bodyPadding: EdgeInsets.fromLTRB(
        16.0, 0, 16.0, 0), // Zmniejszono górną i dolną wartość
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        globalFooter: Padding(
          padding: EdgeInsets.only(bottom: 76),
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MySavingColors.defaultBlueButton),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(
                'Let\'s go right away!',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
        ),
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        pages: [
          PageViewModel(
            title: "Zarabiaj duże kwoty nie wychodząc z domu",
            body:
                "Możesz łatwo zarabiać duże kwoty co pozwoli ci na spełnienie marzeń",
            image: _buildImage('tuto1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
              title: "Szybka wypłata i bezpieczeństwo",
              body:
                  "Pieniądzę odrazu trafiają na twoje konto i nie musisz sie martwić",
              image: _buildImage('tuto2.png'),
              decoration: pageDecoration),
          PageViewModel(
              title: "Ciesz się z bycia własnym szefem",
              body:
                  "Możesz cieszyć sie z niezależności finansowej pracując kiedy chcesz i ile chcesz",
              image: _buildImage('tuto3.png'),
              decoration: pageDecoration),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showNextButton: false,
        showBackButton: false,
        showDoneButton: false,
        showBottomPart: true,
        back: const Icon(
          Icons.arrow_back,
          color: Color(0xff806FF1),
        ),
        skip: const Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF444FFF))),
        next: const Icon(
          Icons.arrow_forward,
          color: Color(0xff806FF1),
        ),
        done: Text('Go Earn',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF444FFF))),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.only(bottom: 56),
        dotsDecorator: DotsDecorator(
          size: Size(20.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeColor: MySavingColors.defaultBlueButton,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Color.fromARGB(221, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ));
  }
}
