import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/bank_request.dart';
import 'package:rosabon/model/request_model/company_document_requestion.dart';
import 'package:rosabon/model/request_model/document_request.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/model/response_models/document_response.dart';
import 'package:rosabon/model/response_models/save_document_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';

class EmploymentRepository {
  final NetworkProvider _networkProvider = NetworkProvider();

  Future<BanksResponse> saveDetails(BankRequest bankRequest) async {
    BanksResponse banksResponse;
    try {
      final encode = jsonEncode(bankRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.individualPerson,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        banksResponse = BanksResponse.fromJson(res.data);
        banksResponse.success = true;
      } else {
        banksResponse = BanksResponse(message: "", success: false);
      }
    } on DioError catch (e) {
      banksResponse = BanksResponse(message: e.message, success: false);
    }
    return banksResponse;
  }

  Future<DocumentResponse> saveDocs(DocumentRequest documentRequest) async {
    DocumentResponse documentResponse;
    try {
      final encode = jsonEncode(documentRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.updateDocuments,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        documentResponse = DocumentResponse.fromJson(
            // {
            //  "docs":
            res.data
            // }
            );
        documentResponse = DocumentResponse(message: "", baseStatus: true);
      } else {
        documentResponse = DocumentResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      documentResponse =
          DocumentResponse(message: e.message, baseStatus: false);
    }
    return documentResponse;
  }

  Future<SaveDocsResponse> saveCompanyDocs(
      CompanyDocumentRequest companyDocumentRequest) async {
    SaveDocsResponse saveDocsResponse;
    try {
      final encode = jsonEncode(companyDocumentRequest.toJson());

      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.companyDocument,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        saveDocsResponse = SaveDocsResponse.fromJson(res.data);
        saveDocsResponse.baseStatus = true;
      } else {
        saveDocsResponse = SaveDocsResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      saveDocsResponse =
          SaveDocsResponse(message: e.message, baseStatus: false);
    }
    return saveDocsResponse;
  }

  Future<DocumentResponse> fetchDocument() async {
    DocumentResponse documentResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.documents, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        documentResponse = DocumentResponse.fromJson(res.data);
        documentResponse.baseStatus = true;
      } else {
        documentResponse = DocumentResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      print(e);
      documentResponse = DocumentResponse(message: e, baseStatus: false);
    }
    return documentResponse;
  }

  Future<SaveDocsResponse> fetchCompanyDocument() async {
    SaveDocsResponse saveDocsResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.companyDocument, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        saveDocsResponse = SaveDocsResponse.fromJson(res.data);
        saveDocsResponse.baseStatus = true;
      } else {
        saveDocsResponse = SaveDocsResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      saveDocsResponse =
          SaveDocsResponse(message: e.message, baseStatus: false);
    }
    return saveDocsResponse;
  }
}
