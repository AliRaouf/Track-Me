part of 'water_cubit.dart';

@immutable
abstract class WaterState {}

class WaterInitial extends WaterState {}
class UpdateWaterLoading extends WaterState {}
class UpdateWaterSuccess extends WaterState {}
class UpdateWaterError extends WaterState {}
class ReceiveWaterLoading extends WaterState {}
class ReceiveWaterSuccess extends WaterState {}
class ReceiveWaterError extends WaterState {}
class AddToCurrentWaterLoading extends WaterState {}
class AddToCurrentWaterSuccess extends WaterState {}
class AddToCurrentWaterError extends WaterState {}