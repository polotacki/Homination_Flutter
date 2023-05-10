
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'custom_modal_bottom_sheet_state.dart';

class CustomModalBottomSheetCubit extends Cubit<CustomModalBottomSheetState> {
  CustomModalBottomSheetCubit() : super(CustomModalBottomSheetInitial());

  static CustomModalBottomSheetCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  PageController controller = PageController(initialPage: 0);

    buttonSelected(int index) {

    currentIndex = index;

    controller.animateToPage(
      index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    emit(CustomModalBottomSheetButtonSelected());
  }
}
