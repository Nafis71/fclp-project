class NetworkUrls {
  static const String baseUrl = "https://fclpbd.xyz/api";
  static const String loginUrl = "$baseUrl/login";
  static const String registrationUrl = "$baseUrl/complete-registration";
  static const String getUserUrl = "$baseUrl/get-user";
  static const String getAirportListUrl = "$baseUrl/airport/list";
  static const String bookTicketUrl = "$baseUrl/air-tickets/store";
  static const String airTicketDeleteUrl = "$baseUrl/air-tickets/delete";
  static const String ticketUrl = "$baseUrl/air-tickets/list";
  static const String productUrl = "$baseUrl/product/list?";
  static const String userUpdateUrl = "$baseUrl/user/update";
  static const String airTicketUpdateUrl = "$baseUrl/air-tickets/edit";
  static const String passwordChangeUrl = "$baseUrl/setup-password";
  static const String accountActiveRequest = "$baseUrl/account-active-request";
  static const String logoutUrl = "$baseUrl/logout";
  static const String storageBaseUrl = "https://fclpbd.xyz/public/storage/";
  static const String cartListUrl = "$baseUrl/cart/list";
  static const String cartStoreUrl = "$baseUrl/cart/store";
  static const String cartDeleteUrl = "$baseUrl/cart/delete";
  static const String cartToOrder = "$baseUrl/cart-to-order";
  static const String orderList = "$baseUrl/order/list";
  static const String confirmDeliveryCost = "$baseUrl/confirm-delivery-cost";
  static const String payDeliveryCost = "$baseUrl/pay-delivery-cost";
  static const String deleteOrder = "$baseUrl/order";
  static const String referrals = "$baseUrl/user/referrals";
  static const String pointRedeemUrl = "$baseUrl/coin-redeem";
}
