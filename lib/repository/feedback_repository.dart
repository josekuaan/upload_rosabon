import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/createTicket_request.dart';
import 'package:rosabon/model/request_model/replychat_request.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/model/response_models/help_response.dart';
import 'package:rosabon/model/response_models/ticketCategory_response.dart';
import 'package:rosabon/model/response_models/ticket_response.dart';
import 'package:rosabon/model/response_models/ticketchat_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';

class FeedBackRepository {
  final NetworkProvider _networkProvider = NetworkProvider();
  Future<BanksResponse> createTicket(
      CreateTicketrequest createTicketrequest) async {
    BanksResponse banksResponse;
    try {
      final encoded = jsonEncode(createTicketrequest.toJson());

      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          body: encoded,
          path: AppConfig.createticket,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        // banksResponse = BanksResponse.fromJson(res.data);
        // banksResponse.success = true;
        banksResponse =
            BanksResponse(message: "Ticket Created successful", success: true);
      } else {
        banksResponse = BanksResponse(message: "", success: false);
      }
    } on DioError catch (e) {
      banksResponse = BanksResponse(message: e.message, success: false);
    }
    return banksResponse;
  }

  Future<HelpResponse> fetchHelp() async {
    HelpResponse helpResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.help,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        helpResponse = HelpResponse.fromJson(res.data["data"]);
        helpResponse.baseStatus = true;
      } else {
        helpResponse = HelpResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      helpResponse = HelpResponse(message: e.message, baseStatus: false);
    }
    return helpResponse;
  }

  Future<TicketCategoryResponse> fetchCategory() async {
    TicketCategoryResponse ticketCategoryResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.getallcategory,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        ticketCategoryResponse =
            TicketCategoryResponse.fromJson({"data": res.data});
        ticketCategoryResponse.baseStatus = true;
      } else {
        ticketCategoryResponse =
            TicketCategoryResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      ticketCategoryResponse =
          TicketCategoryResponse(message: e.message, baseStatus: false);
    }
    return ticketCategoryResponse;
  }

  Future<TicketResponse> openTickets() async {
    TicketResponse ticketResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.openTickets,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        ticketResponse = TicketResponse.fromJson({"ticket": res.data});
        ticketResponse.baseStatus = true;
      } else {
        ticketResponse = TicketResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      ticketResponse = TicketResponse(message: e, baseStatus: false);
    }
    return ticketResponse;
  }

  Future<TicketResponse> closeTickets() async {
    TicketResponse ticketResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.closedTickets,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        ticketResponse = TicketResponse.fromJson({"ticket": res.data});
        ticketResponse.baseStatus = true;
      } else {
        ticketResponse = TicketResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      ticketResponse = TicketResponse(message: e.message, baseStatus: false);
    }
    return ticketResponse;
  }

  Future<TicketChatResponse> ticketReply(int id) async {
    TicketChatResponse ticketChatResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.ticketReply(id),
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        ticketChatResponse = TicketChatResponse.fromJson({"reply": res.data});
        ticketChatResponse.baseStatus = true;
      } else {
        ticketChatResponse = TicketChatResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      ticketChatResponse = TicketChatResponse(message: e, baseStatus: false);
    }
    return ticketChatResponse;
  }

  Future<TicketChatResponse> replyChat(
      ReplyCahtrequest replyCahtrequest) async {
    TicketChatResponse ticketChatResponse;
    try {
      final encoded = jsonEncode(replyCahtrequest.toJson());
      var res = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          body: encoded,
          path: AppConfig.replyChat,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        ticketChatResponse = TicketChatResponse.fromJson({"reply": res.data});
        ticketChatResponse.baseStatus = true;
      } else {
        ticketChatResponse = TicketChatResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      ticketChatResponse =
          TicketChatResponse(message: e.message, baseStatus: false);
    }
    return ticketChatResponse;
  }
}
