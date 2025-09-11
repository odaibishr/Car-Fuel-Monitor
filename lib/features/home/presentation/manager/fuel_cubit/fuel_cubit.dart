import 'package:bloc/bloc.dart';
import 'package:car_monitor/features/home/data/model/fuel_model.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';

part 'fuel_state.dart';

class FuelCubit extends Cubit<FuelState> {
  FuelCubit(this.fuelRepo) : super(FuelInitial());

  final FuelRepo fuelRepo;

  Future<void> getFuelData() async {
    emit(FuelLoading());
    try {
      var result = await fuelRepo.getFuelData();
      
      result.fold((failure) => emit(FuelError(message: failure.errorMessage)),
          (fuelModel) => emit(FuelSuccess(fuelModel: fuelModel)));
    } catch (e) {
      emit(FuelError(message: e.toString()));
    }
  }
}
