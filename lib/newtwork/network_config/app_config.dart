abstract class AppConfig {
  static String baseurl = "https://api-rosabon.optisoft.com.ng:8090";
  // static String baseurl = "https://api-rosabon.optisoft.com.ng:8090 ";

  static String signup = "$baseurl/users";
  static String login = "$baseurl/login";
  static String logout = "$baseurl/auth/logout";
  static String gender = "$baseurl/auth/admin/gender";
  // static String gender = "$baseurl/auth​/admin​/gender";
  static String registertoken = "$baseurl/notification/register-token";
  static String getSource = "$baseurl/auth/admin/sources";
  // static String getSource = "$baseurl/auth​/admin​/sources";
  static String countries = "$baseurl/country";
  static String kyc = "$baseurl/auth/users";
  static String updateBvnName = "$baseurl/auth/users/update-first-last-name";
  static String state(int id) => "$baseurl/state/$id";
  static String user(String name) => "$baseurl/auth/$name/users";
  static String userDetails = "$baseurl/auth/users";
  static String notification = "$baseurl/notification";
  static String notificationById(int id) => "$baseurl/notification/$id";
  static String forgotpassword(String email) =>
      "$baseurl/users/$email/forgot-password";
  static String changepassword = "$baseurl/auth/users/change-password";
  static String resestPassword = "$baseurl/users/reset-password";

  static String individualPerson = "$baseurl/auth/individual-user";
  static String directorDetails = "$baseurl/auth/company/director-details";
  static String deleteDirector(int id) =>
      "$baseurl/auth/company/director-details/$id";
  static String fetchDirector = "$baseurl/auth/company/director-details";
  static String individualOtp = "$baseurl/auth/individual-user/send-otp";
  static String generalOtp = "$baseurl/auth/users/send-otp";
  static String directorOtp = "$baseurl/auth/company/director-details/send-otp";
  static String companyOtp = "$baseurl/auth/company/company-document/send-otp";
  // static String individualOtp =
  //     "$baseurl/auth/individual-user/my-document/send-otp";
  // static String employmentDetailsById(id) => "$baseurl/employmentDetails/$id";
  // static String documents = "$baseurl/auth/individual-user/my-document";
  static String updateDocuments = "$baseurl/auth/individual-user/my-document";
  static String documents =
      "$baseurl/auth/individual-user/my-document/get-by-user";
  static String companyDocument = "$baseurl/auth/company/company-document";
  static String companyDetails = "$baseurl/auth/company";
  static String verifyBvn = "$baseurl/auth/verify-bvn";
  static String banks = "$baseurl/bank-account/get-all-banks";
  static String bankaccount = "$baseurl/auth/individual-user/bank-account";
  static String virtualdynamicaccount =
      "$baseurl/providus/create-dynamic-account";
  static String virtualaccount = "$baseurl/providus/virtual-account";
  static String viewbankdetails =
      "$baseurl/auth/trplan-action/view-bank-details";
  static String verifyAccount =
      "$baseurl/auth/individual-user/bank-account/verify";
  static String updateBankAccount =
      "$baseurl/auth/individual-user/bank-account";
  static String bankAccountSendOtp =
      "$baseurl/auth/individual-user/bank-account/send-otp";
  static String validatePhone(phomeNumber) =>
      "$baseurl/auth/individual-user/verify-phone/$phomeNumber";
  static String validateOtp(String otp) => "$baseurl/auth/validate-otp/$otp";

  static String getWallet = "$baseurl/auth/wallet-transactions";
  static String wallettransfer = "$baseurl/auth/wallets/wallet-transfer";
  static String walletBalance = "$baseurl/auth/wallet-balance";
  static String withdrawalReason = "$baseurl/auth/trwithdrawal";
  static String requestwithdrawal = "$baseurl/auth/wallets/request-withdrawal";
  static String getallcategory = "$baseurl/auth/feedback/categories";
  static String createticket = "$baseurl/auth/feedback";
  static String closedTickets = "$baseurl/auth/feedback/closed-tickets";
  static String openTickets = "$baseurl/auth/feedback/open-tickets";
  static String replyChat = "$baseurl/auth/feedback/reply-ticket";
  static String ticketReply(int ticketId) =>
      "$baseurl/auth/feedback/ticket-reply/$ticketId";
  static String allproducts = "$baseurl/auth/trproduct";
  static String getProductById(int id) => "$baseurl/auth/trproduct/$id";
  static String products = "$baseurl/auth/trproduct-category/trproduct";
  // static String products = "$baseurl/auth/trproduct-category";
  // static String createPlan = "$baseurl/auth/user/trcreate-plan?limit=3";
  static String createPlan = "$baseurl/auth/trcreate-plan?limit=3";
  static String updatePlan(int id) => "$baseurl/auth/trcreate-plan/update/$id";
  static String fetchClosePlan =
      "$baseurl/auth/trcreate-plan/get-all-closed-plans";
  static String planhistory(int planId) =>
      "$baseurl/auth/tr-plan-history/$planId";
  static String eligibleplansfortransfer =
      "$baseurl/auth/wallet-transfer/eligible-plans-for-transfer";
  static String planAction = "$baseurl/auth/trplan-action";
  static String paywithcard = "$baseurl/auth/trplan-action/pay-with-card";
  static String deletePlan(int id) => "$baseurl/auth/trplan-action/$id";
  static String completePlan = "$baseurl/auth/trplan-action/complete-transfer";
  static String trcurrency = "$baseurl/auth/trcurrency";
  static String investmentrate = "$baseurl/auth/trinvestment-rates";
  static String withholdingrate = "$baseurl/auth/trwithholding-tax";
  static String trexchangerate = "$baseurl/auth/trexchange-rates";
  static String penalcharge = "$baseurl/auth/trpenal-charge";
  static String trtenor = "$baseurl/auth/trtenor";
  static String initPayment = "$baseurl/auth/initialize-payment";
  static String paymentInitialize = "$baseurl/auth/transactions";
  static String verifyPayment(String paymentGateway, String transactionRef) =>
      "$baseurl/auth/payment-verification/$paymentGateway/$transactionRef";
  // static String paymentverification(String paymentGateway, String ref) =>
  //     "$baseurl/auth/payment-verification/$paymentGateway/$ref";

  static String help = "$baseurl/auth/faq";
  static String identificationType = "$baseurl/auth/admin/identification-type";
  static String myreferrals = "$baseurl/auth/referrals";
  static String referralsactivities = "$baseurl/auth/referrals/activities";
  static String threshold =
      "$baseurl/auth/wallets/get-referral-redeem-threshold";
  static String redeembonus = "$baseurl/auth/referrals/redeem-bonus";
  static String mydeposit =
      "$baseurl/auth/my-deposits/activities/?limit=1000000";
  static String specialearnings = "$baseurl/auth/special-earnings/activities";
  static String getTotalSpecialEarning =
      "$baseurl/auth/special-earnings/total-redeemed-earning";
  static String totalearning = "$baseurl/auth/special-earnings/total-earning";
  static String redeemspecialBonus =
      "$baseurl/auth/special-earnings/redeem-bonus";
  static String pokeUser(int pokedUserId) =>
      "$baseurl/auth/referrals/poke/$pokedUserId";
}
