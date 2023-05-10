
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'custom_modal_bottom_sheet_state.dart';

class CustomModalBottomSheetCubit extends Cubit<CustomModalBottomSheetState> {
  CustomModalBottomSheetCubit() : super(CustomModalBottomSheetInitial());

  static CustomModalBottomSheetCubit get(context) => BlocProvider.of(context);


}
