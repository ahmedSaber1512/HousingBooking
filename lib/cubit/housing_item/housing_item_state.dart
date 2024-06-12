part of 'housing_item_cubit.dart';

@immutable
sealed class HousingItemState {
  get cubit => null;
}

final class HousingItemInitial extends HousingItemState {}
final class isLoading extends HousingItemState {}

