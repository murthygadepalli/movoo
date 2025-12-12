import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class Config{

  static final oneSignal = dotenv.env['ONE_SIGNAL_KEY'] ?? '';

  static const String baseUrl = 'https://platix-server-gray.vercel.app/';
  static const googleKey = "AIzaSyCtwQS1XF0mY8fiLtz_OolVzJvF6Pciorw";
  static const oneSignalSubscribe = "user/one-subscribe";
  static const removeSignalSubscribe = "user/remove-one-subscribe";

  static const dentistLoginApi="login/verify-mobile";
  static const loginApi="login/login-mobile";
  static const createRoleApi = "login/create-role";
  static const roleListApi = "admin/viewrole";
  static const deleteApi = "profile/delete/";
  static const getDentistOrganizations = "dentist/get-dentist-organization";
  static const requestEmailOtp = 'login/email-sent';
  static const verifyEmailOtp = "login/verify-otp";


  ///Dentist-API'S
  static const dentistDashboard="dashboard/all-orders";
  static const dentistDashboardData="dashboard/all";
  static const dentistCancelOrder="dentist/upsert/cancel";
  static  dentistServicesDetails(String id)=> "dentist/organization-details/getbyid/$id";
  static  dentistOrderDetails(String id)=> "dentist/order/getbyid/$id";
  static  dentistOrders(String id,String status)=> "dashboard/status/$status/$id";
  static const dentistEditOrder = "/dentist/upsert";
  //static  searchByDate(DateTime fromdate,DateTime todate )=> "dentist/order/report/$fromdate/$todate";
  static searchByDate(DateTime fromdate, DateTime todate) {
    // Format DateTime to "YYYY-MM-DD" to match API format
    String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromdate);
    String formattedToDate = DateFormat('yyyy-MM-dd').format(todate);

    return "/dentist/order/report/$formattedFromDate/$formattedToDate";
  }
  static const dentistReportApi="dentist/order/report";
  static  dentistOrderReportsDetails(String id)=> "dentist/order/getbyid/$id";
  static  dentistPaymentReportsDetails(String id)=> "dentist//order/payment-report-getbyid/$id";
  static reportSearch(String name) => "dentist/order/search/$name";
  static paymentSearch(String query) => "dentist/order/search/$query";


  ///Owner-APIs
  static const ownerDashboard = "owner/dashboard";
  static const ownerCreateOrder = "owner/upsert";
  static const ownerCreateDoctor = "owner/upsert-doctor";
  static String ownerSearchDoctor(String doctor) => "owner/doctor/search/$doctor";
  static String ownerOrdersApi(String status) => "owner/getall-order/$status";
  static String ownerRadiologyOrders(String status) => "owner/orders/$status";
  static String ownerDashboardSearch(String query) => "owner/order/dashboard/search-orders/?search=$query";
  static const ownerReportPayments = 'owner/report/payment';

  ///Same API for order details
  static String ownerReportDetails(String id, String type) => 'owner/order/report/$id/$type';
  static String ownerReportSearch(String query) => 'owner/order/search/$query';
  static String ownerReportSearchByDate(DateTime fromDate, DateTime toDate){
    String formatedFromDate = DateFormat('yyyy-MM-dd').format(fromDate);
    String formatedToDate = DateFormat('yyyy-MM-dd').format(toDate);

    return 'owner/report/order/$formatedFromDate/$formatedToDate';
  }
  static const ownerAssignApi = "owner/assign-service";
  static const ownerHospitalList = "owner/get-hospital-name";
  static const ownerDeliveryBoyList = "owner/get-delivery-boy";
  static const ownerTechnicianList = "owner/get-technician";
  static String ownerCancelOrCancel(String status) => "owner/upsert/$status";
  static String ownerEditInvoice(String id) => "owner/edit-invoice/$id";
  static String ownerRaiseInvoice(String id) => "owner/raise-invoice/$id";
  static const ownerClearCancelled = 'owner/delete/cancelled';
  static const ownerClearCompleted = 'owner/delete/completed';
  static String ownerImageUpload(String id) => 'owner/upload-images?orderId=$id';


  ///Technician-APIs
  static const techDashboard = 'technician/dashboard';
  static const techClearCancelled = 'technician/clear-cancelled';
  static const techClearCompleted = 'technician/clear-completed';
  static String techOrdersApi(String status) => 'technician/order-status?orderStatus=$status';
  static String techOrdersDetailsApi(String id) => 'technician/order-details/$id';
  static String techCancelAndCloseOrder(String status) => 'technician?action=$status';
  static String techImageUpload(String id) => 'technician/upload-images?orderId=$id';
  static String techDashboardSearch(String query) => 'technician/orders/search?$query';


  ///Edit Profile(Except dentist)
  static const editProfile = 'profile/update';

  ///Notification-API
  static const notificationApi = 'notifications/get-notifications';

  ///payment
  static const createCashFreeOrder = 'payment/create-order';
  static checkPaymentStatus(String orderId) => 'payment/status/$orderId';


  ///Delivery Boy-APIs
//static  dbDashboard(String query) => 'delivery/getall?search=$query';

  static String dbDashboard(String query) {
    return query.isNotEmpty
        ? 'delivery/getall?search=$query'
        : 'delivery/getall';
  }

  static String dbOrdersApi(String status) => 'delivery/getall-order/$status';
  static String dbOrdersDetailsApi(String id) => 'delivery/order/getbyid/$id';
  static const deliveryCreateOrder = "delivery/upsert";
  static dbClosedOrder(String id) => "delivery/closed-order/$id";
  static const String  dbCancelOrder = "delivery/upsert/cancel";
  static String  dbClearAll(status) => "delivery/delete/$status";

}