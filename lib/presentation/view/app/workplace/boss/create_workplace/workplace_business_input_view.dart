import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/hint_input_box.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// 사업자 정보 입력
class WorkplaceBusinessInputView extends BaseView<CreateWorkplaceViewModel> {
  const WorkplaceBusinessInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseAppBar(
        title: "일터 생성",
        leadIcon: Icons.arrow_back_ios_rounded,
      ),
      body: disallowIndicatorWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("사업자 정보 입력", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text(
                      "사업자 인증을 통해 추후 관련 정보와 혜택을 제공받을 수 있어요.\n업태 및 상호명 외에는 사업자 여부 판단 외에는 사용되지 않으니\n안심하고 입력해 주세요!",
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 30),
                    TitleTextField(
                      title: '사업자 번호',
                      hintText: '000-00-00000',
                      keyboardType: TextInputType.number,
                      inputFormatter: MaskTextInputFormatter(
                        mask: '###-##-#####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                      onChange: (text) => controller.businessNumber(text),
                    ),
                    const SizedBox(height: 20),
                    TitleTextField(
                        title: '대표자 성명', hintText: '홍길동', onChange: (text) => controller.bossNameOfBusiness(text)),
                    const SizedBox(height: 20),
                    const Text("개업일자", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    /** 개업일자 선택 날짜 **/
                    GestureDetector(
                      child: TextField(
                        style: const TextStyle(fontSize: 14),
                        enabled: false,
                        // readOnly: true,
                        cursorColor: MyColors.primary,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          hintText: "0000년 00월 00일",
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.black)),
                        ),
                        controller: controller.openingDateController,
                        onChanged: (text) => controller.openingDateOfBusiness(text),
                      ),
                      onTap: () async {
                        Future<DateTime?> selectedDate = showDatePicker(
                          context: context,
                          initialDate: DateTime(2022),
                          firstDate: DateTime(1960, 1, 1),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(data: ThemeData(), child: child!);
                          },
                        );

                        selectedDate.then((dateTime) {
                          controller.openingDateOfBusiness.value = dateTime.toString();
                          controller.openingDateController.text = DateFormat('yyyy-MM-dd').format(dateTime!);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TitleTextField(
                        title: '상호명(법인명)', hintText: '알바노트', onChange: (text) => controller.businessName(text)),
                    Row(children: [
                      Obx(() => Checkbox(
                          value: controller.isCorporateBusiness.value,
                          onChanged: (bool? value) => controller.isCorporateBusiness(value))),
                      const Text('법인회사'),
                    ]),
                    const SizedBox(height: 20),
                    TitleTextField(
                        title: '주업태',
                        hintText: '서비스',
                        onChange: (text) => controller.typeObBusiness(text),
                        textInputAction: TextInputAction.done),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
              Obx(() {
                var isEnable = false;
                if (controller.businessNumber.value.length > 10 &&
                    controller.bossNameOfBusiness.value.length > 1 &&
                    controller.openingDateOfBusiness.value.isNotEmpty &&
                    controller.businessName.value.isNotEmpty &&
                    controller.typeObBusiness.value.isNotEmpty) {
                  isEnable = true;
                }
                return buildBottomButton(
                    text: '일터 생성',
                    isEnable: isEnable,
                    negativeButtonText: "건너뛰기",
                    onPositiveTab: () {},
                    onNegativeTab: () {
                      showAlertDialog(
                          title: '사업자 정보 입력 건너뛰기',
                          content: '사업자 정보를 입력하면\n추후에 여러가지 혜택을 받을 수 있어요.',
                          positiveButtonText: '입력하기',
                          negativeBtnText: '건너뛰기',
                          barrierDismissible: true);
                    });
              }),
              /// todo 사업자 정보 입력 건너뛰기 및 완료 결과 서버 반영  ㄲ
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
