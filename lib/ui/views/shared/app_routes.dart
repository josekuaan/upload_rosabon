import 'package:flutter/material.dart';
import 'package:rosabon/ui/auth/forgot_password_screen.dart';
import 'package:rosabon/ui/auth/login_screen.dart';
import 'package:rosabon/ui/auth/onboarding_screen1.dart';
import 'package:rosabon/ui/auth/onbord.dart';
import 'package:rosabon/ui/auth/onbording_screen.dart';
import 'package:rosabon/ui/auth/pReset_successful.dart';
import 'package:rosabon/ui/auth/reg_successful.dart';
import 'package:rosabon/ui/auth/reset_password_screen.dart';
import 'package:rosabon/ui/auth/sign_up_company_screen.dart';
import 'package:rosabon/ui/auth/sign_up_screen.dart';
import 'package:rosabon/ui/auth/splash_Screen.dart';
import 'package:rosabon/ui/auth/splash_screen1.dart';
import 'package:rosabon/ui/dashboard/archive/archive_screen.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/bank_details.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/confirm_transaction_details.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/partial_payment_info.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_plan.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/plan_detail.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/product_screen.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/rollover.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/rollover_summary.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/top_up.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/transfer.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widthraw/withdraw.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widthraw/withdraw_summary.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widthraw/withdrawal_destination.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/dashboard/feed_back/feed_back.dart';
import 'package:rosabon/ui/dashboard/feed_back/messaging.dart';
import 'package:rosabon/ui/dashboard/help/help_screen.dart';
import 'package:rosabon/ui/dashboard/home/calculate_investment.dart';
import 'package:rosabon/ui/dashboard/statement/statement.dart';
import 'package:rosabon/ui/dashboard/wallet/company_withdraw_to_bank.dart';
import 'package:rosabon/ui/dashboard/wallet/my_deposit.dart';
import 'package:rosabon/ui/dashboard/wallet/my_referral.dart';
import 'package:rosabon/ui/dashboard/wallet/my_referral_bonus.dart';
import 'package:rosabon/ui/dashboard/wallet/my_transaction_details.dart';
import 'package:rosabon/ui/dashboard/wallet/my_transfer.dart';
import 'package:rosabon/ui/dashboard/wallet/widgets/bank_transactions.dart';
import 'package:rosabon/ui/dashboard/wallet/special_earning.dart';
import 'package:rosabon/ui/dashboard/wallet/wallet_to_bank.dart';
import 'package:rosabon/ui/kyc/company_update.dart';
import 'package:rosabon/ui/kyc/kyc_update.dart';
import 'package:rosabon/ui/notification/notification.dart';
import 'package:rosabon/ui/notification/notification_detail.dart';
import 'package:rosabon/ui/profiles/change_password/change_password_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/corprate_contact_detail_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/corprate_info_detail_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/corprate_info_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/corprate_profile_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/director_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/documents_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/more_detail_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/referral/corprate_referral_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/widget/edit_director.dart';
import 'package:rosabon/ui/profiles/corprate_profile/widget/view_director.dart';
import 'package:rosabon/ui/profiles/individual_profile/documents/documents_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/documents/view_image_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/my_bank_detail/my_bank_details.dart';
import 'package:rosabon/ui/profiles/individual_profile/personal_information/contact_detail_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/personal_information/employment_detail_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/personal_information/next_of_kin.dart';
import 'package:rosabon/ui/profiles/individual_profile/personal_information/personal_info_detail_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/personal_information/personal_info_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/profile_screen.dart';
import 'package:rosabon/ui/profiles/individual_profile/referral/referral_screen.dart';
import 'package:rosabon/ui/widgets/success.dart';

class AppRouter {
  static String splash1 = "/splash1";
  static String splash = "/splash";
  static String onboarding1 = "/onboarding1";
  static String onboarding = "/onboarding";
  static String onboard = "/onboard";
  static String signup = "/signup";
  static String cSignup = "/cSignup";
  static String login = "/login";
  static String forgotPassword = "/forgotPassword";
  static String resetPassword = "/resetPassword";
  static String success = "/success";
  static String regSuccess = "/regSuccess";
  static String pResetSuccess = "/pResetSuccess";
  static String personalKyc = "/personalKyc";
  static String companyKyc = "/companyKyc";
  static String profile = "/profile";
  static String personalinfo = "/personalinfo";
  static String personalinfodetail = "/personalinfodetail";
  static String personalcontactdetail = "/personalcontactdetail";
  static String corprateprofile = "/corprateprofile";
  static String corprateinfo = "/corprateinfo";
  static String corprateinfodetail = "/corprateinfodetail";
  static String corpratecontactdetail = "/corpratecontactdetail";
  static String director = "/director";
  static String viewdirector = "/viewdirector";
  static String editDirector = "/editDirector";
  static String employmentdetail = "/employmentdetail";
  static String products = "/products";
  static String mydocument = "/mydocument";
  static String companydocument = "/companydocument";
  static String nextofkindetails = "/nextofkindetails";
  static String mybankDetail = "/mybankDetail";
  static String dashboard = "/dashboard";
  static String plansummary = "/plansummary";
  static String investmentcalculator = "/investmentcalculator";
  static String paymentplan = "/paymentplan";
  static String paymentinfo = "/paymentinfo";
  static String plandetail = "/plandetail";
  static String topup = "/topup";
  static String rollover = "/rollover";
  static String transfer = "/transfer";
  static String withdraw = "/withdraw";
  static String rolloversummary = "/rolloversummary";
  static String withdrawsummary = "/withdrawsummary";
  static String mydeposit = "/mydeposit";
  static String bankDetails = "/bankDetails";
  static String partialPayment = "/partialPayment";
  static String withdrawaldestination = "/withdrawaldestination";
  static String wallettobank = "/wallettobank";
  static String companywithdrawtobank = "/companywithdrawtobank";
  static String paymentsuccess = "/paymentsuccess";
  static String confirmTransation = "/confirmTransation";
  static String notification = "/notification";
  static String notificationdetail = "/notificationdetail";
  static String referralLink = "/referralLink";
  static String help = "/help";
  static String feedback = "/feedback";
  static String archive = "/archive";
  static String statement = "/statement";
  static String corpratereferralLink = "/corpratereferralLink";
  static String changepassword = "/changepassword";
  static String previewImage = "/previewImage";
  static String myreferral = "/myreferral";
  static String myreferralbonus = "/myreferralbonus";
  static String mytransfer = "/mytransfer";
  static String mytransactiondetails = "/mytransactiondetails";
  static String singletransactions = "/singletransactions";
  static String specialearning = "/specialearning";
  static String messaging = "/messaging";

  static Map<String, WidgetBuilder> routes = {
    splash1: (context) => const SplashScreen1(),
    splash: (context) => const SplashScreen(),
    onboarding1: (context) => const OnboardingScreen1(),
    onboard: (context) => const Onboard(),
    onboarding: (context) => const OnboardingScreen(),
    signup: (context) => const SignupScreen(),
    cSignup: (context) => const SignUpCompanyScreen(),
    login: (context) => const LoginScreen(),
    personalKyc: (context) => const KycUpdate(),
    companyKyc: (context) => const CompanyUpdate(),
    profile: (context) => ProfileScreen(),
    dashboard: (context) => Dashboard(),
    personalinfo: (context) => const PersonalinformationScreen(),
    personalinfodetail: (context) => const PersonalInfoDetailScreen(),
    personalcontactdetail: (context) => const PersonalContactDetailScreen(),
    corprateprofile: (context) => CorprateProfileScreen(),
    corprateinfo: (context) => const CorprateInformationScreen(),
    corprateinfodetail: (context) => const CorprateInfoDetailScreen(),
    corpratecontactdetail: (context) => const CorprateContactDetailScreen(),
    director: (context) => const DirectorScreen(),
    viewdirector: (context) => const ViewDirector(),
    editDirector: (context) => const EditDirector(),
    employmentdetail: (context) => const EmploymentDetails(),
    mydocument: (context) => const DocumentScreen(),
    companydocument: (context) => const CompanyDocumentScreen(),
    nextofkindetails: (context) => const NextofKinDetails(),
    mybankDetail: (context) => const MyBankDetailsScreen(),
    referralLink: (context) => ReferralScreen(),
    help: (context) => const HelpScreen(),
    feedback: (context) => const FeedBack(),
    products: (context) => const ProductScreen(),
    // plansummary: (context) => const PlanSummary(),
    paymentplan: (context) => const PaymentPlan(),
    mytransfer: (context) => const MyTransfer(),
    paymentsuccess: (context) => const PaymentSuccess(),
    plandetail: (context) => const PlanDetail(),
    bankDetails: (context) => const BankDetails(),
    topup: (context) => const TopUp(),
    // rollover: (context) => const RollOver(),
    transfer: (context) => const Transfer(),
    withdraw: (context) => const Withdraw(),
    rolloversummary: (context) => const RolloverSummary(),
    // withdrawsummary: (context) => const WithdrawSummary(),
    withdrawaldestination: (context) => const WithdrawalDestination(),
    wallettobank: (context) => const WalletToBank(),
    companywithdrawtobank: (context) => const CompanyWithdrawToBank(),
    mydeposit: (context) => const MyDeposit(),
    mytransactiondetails: (context) => const MyTransactionDetails(),
    singletransactions: (context) => const Banktransactions(),
    // partialPayment: (context) => const PartialPaymentInfo(),
    confirmTransation: (context) => const ConfirmTransaction(),
    investmentcalculator: (context) => const Investmentcalculator(),
    corpratereferralLink: (context) => CorprateReferralScreen(),
    previewImage: (context) => ViewImageScreen(),
    myreferral: (context) => const MyReferral(),
    archive: (context) => const ArchiveScreen(),
    statement: (context) => const Statement(),
    myreferralbonus: (context) => const MyReferralBonus(),
    specialearning: (context) => const SpecialEarning(),
    notification: (context) => const AppNotification(),
    notificationdetail: (context) => const NotificationDetail(),
    changepassword: (context) => const ChangePasswordScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    resetPassword: (context) => const ResetPasswordScreen(),
    success: (context) => Success(),
    regSuccess: (context) => const RegSuccessful(),
    pResetSuccess: (context) => const PasswordResetSuccessful(),
    messaging: (context) => const Messaging(),
  };
}
