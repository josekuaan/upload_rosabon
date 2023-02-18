import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/withdrawal_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/bonus_response.dart';
import 'package:rosabon/model/response_models/deposit_history_response.dart';
import 'package:rosabon/model/response_models/myreferal_response.dart';
import 'package:rosabon/model/response_models/transaction_response.dart';
import 'package:rosabon/model/response_models/wallet_response.dart';
import 'package:rosabon/model/response_models/walletplantransfer_request.dart';
import 'package:rosabon/model/response_models/withdrawalReason_response.dart';
import 'package:rosabon/repository/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository = WalletRepository();
  WalletBloc() : super(const WalletInitial()) {
    on<WalletEvent>((event, emit) async {
      if (event is FetchWalletBalance) {
        await fetchWalletBalance(event, emit);
      }
      if (event is FetchWithdrawalReason) {
        await withdrawalReason(event, emit);
      }
      if (event is FetchWalletTransctions) {
        await fetchWalletTransactions(event, emit);
      }
      if (event is FetchDepositTransctions) {
        await fetchDepositTransctions(event, emit);
      }

      if (event is WithdrawNow) {
        await withdrawal(event, emit);
      }
      if (event is WalletTransfer) {
        await wallettransfer(event, emit);
      }
      if (event is MyRefersActivitty) {
        await referralsactivities(event, emit);
      }
      if (event is FetchThreshold) {
        await threshold(event, emit);
      }

      if (event is MyRefers) {
        await myreferrals(event, emit);
      }
      if (event is SpecialActivity) {
        await specialactivities(event, emit);
      }
      if (event is Redeembonus) {
        await redeembonus(event, emit);
      }
      if (event is RedeemSpecialBonus) {
        await redeemspecialBonus(event, emit);
      }
      if (event is GetTotalSpecialEarning) {
        await getTotalSpecialEarning(event, emit);
      }
      if (event is Totalearning) {
        await totalearning(event, emit);
      }
      if (event is PokeUser) {
        await pokeUser(event, emit);
      }
    });
  }

  Future<void> fetchWalletBalance(
      FetchWalletBalance event, Emitter<WalletState> emit) async {
    try {
      emit(const WalletBalanceLoading());

      var res = await walletRepository.fetchWalletBalance();

      if (res.baseStatus) {
        emit(Walletsuccess(walletResponse: res));
      }
    } catch (e) {}
  }

  Future<void> getTotalSpecialEarning(
      GetTotalSpecialEarning event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.getTotalSpecialEarning();

      if (res.baseStatus) {
        emit(TotalSpecialEarningSuccess(baseResponse: res));
      }
    } catch (e) {}
  }

  Future<void> totalearning(
      Totalearning event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.totalearning();

      if (res.baseStatus) {
        emit(TotalearningSuccess(baseResponse: res));
      }
    } catch (e) {}
  }

  Future<void> fetchWalletTransactions(
      FetchWalletTransctions event, Emitter<WalletState> emit) async {
    try {
      emit(const WalletTransLoading());

      var res = await walletRepository.fetchWalletTransactions();

      if (res.baseStatus) {
        emit(TransactionSuccess(transactionResponse: res));
      }
    } catch (e) {
      emit(TransactError(error: e.toString()));
    }
  }

  Future<void> fetchDepositTransctions(
      FetchDepositTransctions event, Emitter<WalletState> emit) async {
    try {
      emit(const WalletTransLoading());

      var res = await walletRepository.fetchDepositTransctions();

      if (res.baseStatus) {
        emit(BankDepositSuccess(depositHistoryResponse: res));
      }
    } catch (e) {}
  }

  Future<void> withdrawalReason(
      FetchWithdrawalReason event, Emitter<WalletState> emit) async {
    try {
      emit(const WalletTransLoading());

      var res = await walletRepository.withdrawalReason();

      if (res.baseStatus) {
        emit(WithdrawalReasonSuccess(withdrawalReasonResponse: res));
      }
    } catch (e) {}
  }

  Future<void> withdrawal(WithdrawNow event, Emitter<WalletState> emit) async {
    try {
      emit(const WithdrawalLoading());

      var res = await walletRepository.withdrawal(event.withdrawalRequest);

      if (res.baseStatus) {
        emit(WithdrawalSuccess(baseResponse: res));
      }
    } catch (e) {
      emit(WithdrawalError(error: e.toString()));
    }
  }

  Future<void> wallettransfer(
      WalletTransfer event, Emitter<WalletState> emit) async {
    try {
      emit(const WithdrawalLoading());

      var res = await walletRepository
          .wallettransfer(event.walletPlanTransferRequest);

      if (res.baseStatus) {
        emit(WalletTransferSuccess(baseResponse: res));
      }
    } catch (e) {
      emit(WalletTransferError(error: e.toString()));
    }
  }

  Future<void> specialactivities(
      SpecialActivity event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.specialactivities();

      if (res.baseStatus) {
        emit(ReferalBonusSuccess(bonuResponse: res));
      }
    } catch (e) {
      emit(MyRefersError(error: e.toString()));
    }
  }

  Future<void> referralsactivities(
      MyRefersActivitty event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.referralsactivities();

      if (res.baseStatus) {
        emit(ReferalBonusSuccess(bonuResponse: res));
      }
    } catch (e) {
      emit(MyRefersError(error: e.toString()));
    }
  }

  Future<void> threshold(
      FetchThreshold event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.threshold();

      if (res.baseStatus) {
        emit(ReferalBonusSuccess(bonuResponse: res));
      }
    } catch (e) {
      emit(MyRefersError(error: e.toString()));
    }
  }

  Future<void> myreferrals(MyRefers event, Emitter<WalletState> emit) async {
    try {
      emit(const MyRefersLoading());

      var res = await walletRepository.myreferrals();

      if (res.baseStatus) {
        emit(MyRefersSuccess(myreferalResponse: res));
      }
    } catch (e) {
      emit(MyRefersError(error: e.toString()));
    }
  }

  Future<void> redeemspecialBonus(
      RedeemSpecialBonus event, Emitter<WalletState> emit) async {
    try {
      emit(const PokeLoading());

      var res = await walletRepository.redeemspecialBonus();

      if (res.baseStatus) {
        emit(PokeSuccess(baseResponse: res));
      }
    } catch (e) {
      emit(PokeError(error: e.toString()));
    }
  }

  Future<void> redeembonus(Redeembonus event, Emitter<WalletState> emit) async {
    try {
      emit(const PokeLoading());

      var res = await walletRepository.redeembonus();

      if (res.baseStatus) {
        emit(PokeSuccess(baseResponse: res));
      }
    } catch (e) {
      emit(PokeError(error: e.toString()));
    }
  }

  Future<void> pokeUser(PokeUser event, Emitter<WalletState> emit) async {
    try {
      emit(const PokeLoading());

      var res = await walletRepository.pokeUser(event.id);

      if (res.baseStatus) {
        emit(PokeSuccess(baseResponse: res));
      }
    } catch (e) {
      emit(PokeError(error: e.toString()));
    }
  }
}
