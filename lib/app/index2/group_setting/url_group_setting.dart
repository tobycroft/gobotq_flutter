import 'package:gobotq_flutter/app/index2/url_index2.dart';

class Url_group_setting extends Url_Index2 {
  static String Group_Setting_Get = "/v1/group/list/setting";
  static String Group_Setting_Set = "/v1/group/edit/setting";
  static String Group_black_list = "/v1/group/black/list";
  static String Group_black_delete = "/v1/group/black/delete";

  static String Group_Autoreply_list = "/v1/group/autoreply/list";
  static String Group_Autoreply_add = "/v1/group/autoreply/add";
  static String Group_Autoreply_delete = "/v1/group/autoreply/delete";
  static String Group_Autoreply_full_list = "/v1/group/autoreply/full_list";

  static String Group_AutoSend_list = "/v1/group/autosend/list";
  static String Group_AutoSend_delete = "/v1/group/autosend/delete";
  static String Group_AutoSend_get = "/v1/group/autosend/get";
  static String Group_AutoSend_add = "/v1/group/autosend/add";

  static String Group_ban_list = "/v1/group/ban/list";
  static String Group_ban_delete = "/v1/group/ban/delete";

  static String Group_word_list = "/v1/group/word/list";
  static String Group_word_add = "/v1/group/word/add";
  static String Group_word_delete = "/v1/group/word/delete";
}
