import 'dart:io';

const defaultLanguage = "en";

const homeControllerTag = "home_controller_tag";
const interstitialAdControllerTag = "interstitial_ad_controller_tag";
const savedTextsControllerTag = "saved_texts_controller_tag";
const premiumControllerTag = "premium_controller_tag";
const languageControllerTag = "language_controller_tag";

final homeBannerAdId = Platform.isAndroid
    ? "ca-app-pub-2355989529954940/1828338947"
    : "ca-app-pub-2355989529954940/9869205401";
// Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/9214589741'
//     : 'ca-app-pub-3940256099942544/2435281174';
final openSavedTextsInterstitialAdId = Platform.isAndroid
    ? "ca-app-pub-2355989529954940/1581776992"
    : "ca-app-pub-2355989529954940/6178647492";
// Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/1033173712'
//     : 'ca-app-pub-3940256099942544/4411468910';
final savedTextsBannerAdId = Platform.isAndroid
    ? "ca-app-pub-2355989529954940/6460960357"
    : "ca-app-pub-2355989529954940/7531866423";
// Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/9214589741'
//     : 'ca-app-pub-3940256099942544/2435281174';
final decryptInterstitialAdId = Platform.isAndroid
    ? "ca-app-pub-2355989529954940/2975583863"
    : "ca-app-pub-2355989529954940/6218784751";
// Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/1033173712'
//     : 'ca-app-pub-3940256099942544/4411468910';
final saveTextInterstitialAdId = Platform.isAndroid
    ? "ca-app-pub-2355989529954940/9515257276"
    : "ca-app-pub-2355989529954940/4757529273";
    // Platform.isAndroid
    //     ? 'ca-app-pub-3940256099942544/1033173712'
    //     : 'ca-app-pub-3940256099942544/4411468910';
