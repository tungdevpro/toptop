library permission_lib;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'popup_confirm.dart';

class PermissionLib {
  BuildContext? context;

  static final PermissionLib _inst = PermissionLib._internal();

  PermissionLib._internal();

  factory PermissionLib() {
    return _inst;
  }

  void setup(BuildContext ctx) {
    _inst.context = ctx;
  }

  Future<bool> requests(List<Permission> permissions) async {
    List<String> requestTitle = [];
    final Map<Permission, PermissionStatus> status = await permissions.request();
    bool result = true;
    await Future.forEach(status.entries, (MapEntry element) {
      if (element.value != PermissionStatus.granted) {
        requestTitle.add(_getRequestTitle(element.key));
        result = false;
      }
    }).then((_) {
      if (requestTitle.isNotEmpty && _inst.context != null) {
        showDialog(
            context: _inst.context!,
            barrierColor: Colors.transparent,
            builder: (context) => _PopupConfirm(content: 'Bạn cần cấp quyền truy cập ${requestTitle.join(', ')} để tiếp tục'));
      }
    });
    return result;
  }

  // Tối ưu sau
  String _getRequestTitle(Permission permission) {
    switch (permission.toString()) {
      case 'Permission.storage':
        return 'Bộ nhớ';
      case 'Permission.camera':
        return 'Camera';
      case 'Permission.notification':
        return 'Thông báo';
      case 'Permission.location':
        return 'Vị trí';
      case 'Permission.phone':
        return 'Danh bạ';
      case 'Permission.photos':
        return 'Thư viện';
      case 'Permission.microphone':
        return 'Microphone';
      default:
        return '';
    }
  }
}
