class ConfigModel {
  ConfigResponse? item;

  ConfigModel({this.item});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? ConfigResponse.fromJson(json['item']) : null;
  }
}

class ConfigResponse {
  ConfigParameter? config;
  PopupParameter? popup;
  VersionParameter? version;
  OrgParameter? org;

  ConfigResponse({this.config, this.popup, this.version, this.org});

  ConfigResponse.fromJson(Map<String, dynamic> json) {
    config = json['config'] != null ? ConfigParameter.fromJson(json['config']) : null;
    popup = json['popup'] != null ? PopupParameter.fromJson(json['popup']) : null;
    version = json['version'] != null ? VersionParameter.fromJson(json['version']) : null;
    org = json['org'] != null ? OrgParameter.fromJson(json['org']) : null;
  }
}

class ConfigParameter {
  String? facebookPageUrl;
  String? socialNetworkShareUrl;
  String? googleFormsUrl;
  String? hotline;
  String? email;
  bool? allowRegisterKols;
  String? fundraisingStepsUrl;
  String? deepLinkMiniapp;
  bool? allowDeepLink;
  String? linkDownLoadApp;

  ConfigParameter(
      {this.facebookPageUrl,
      this.socialNetworkShareUrl,
      this.googleFormsUrl,
      this.hotline,
      this.email,
      this.allowRegisterKols,
      this.fundraisingStepsUrl,
      this.deepLinkMiniapp,
      this.allowDeepLink,
      this.linkDownLoadApp});

  ConfigParameter.fromJson(Map<String, dynamic> json) {
    facebookPageUrl = json['facebookPageUrl'];
    socialNetworkShareUrl = json['socialNetworkShareUrl'];
    googleFormsUrl = json['googleFormsUrl'];
    hotline = json['hotline'];
    email = json['email'];
    allowRegisterKols = json['allowRegisterKols'];
    fundraisingStepsUrl = json['fundraisingStepsUrl'];
    deepLinkMiniapp = json['deepLinkMiniapp'];
    allowDeepLink = json['allowDeepLink'];
    linkDownLoadApp = json['linkDownLoadApp'];
  }
}

class PopupParameter {
  String? id;
  String? photo;
  String? firtDate;
  String? lastDate;
  String? link;
  String? type;
  String? objectType;
  String? objectId;
  String? data;
  int? displayTimeApp;

  PopupParameter({this.id, this.photo, this.firtDate, this.lastDate, this.link, this.type, this.objectType, this.objectId, this.data, this.displayTimeApp});

  PopupParameter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    firtDate = json['firtDate'];
    lastDate = json['lastDate'];
    link = json['link'];
    type = json['type'];
    objectType = json['objectType'];
    objectId = json['objectId'];
    data = json['data'];
    displayTimeApp = json['displayTimeApp'];
  }
}

class VersionParameter {
  String? id;
  String? activeStatus;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? version;
  int? versionCode;
  String? description;
  bool? forceUpdate;
  int? forceUpdateMinVerCode;
  int? displayTimeApp;
  List<Photos>? photos;
  List<ReleaseModel>? releases;

  VersionParameter(
      {this.id,
      this.activeStatus,
      this.createdTime,
      this.updatedTime,
      this.name,
      this.version,
      this.versionCode,
      this.description,
      this.forceUpdate,
      this.forceUpdateMinVerCode,
      this.displayTimeApp,
      this.photos,
      this.releases});

  VersionParameter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activeStatus = json['activeStatus'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    version = json['version'];
    versionCode = json['versionCode'];
    description = json['description'];
    forceUpdate = json['forceUpdate'];
    forceUpdateMinVerCode = json['forceUpdateMinVerCode'];
    displayTimeApp = json['displayTimeApp'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['releases'] != null) {
      releases = <ReleaseModel>[];
      json['releases'].forEach((v) {
        releases!.add(ReleaseModel.fromJson(v));
      });
    }
  }
}

class Photos {
  String? id;
  String? createdTime;
  String? ownerId;
  String? type;
  String? name;
  String? description;
  String? url;
  String? mediaUploadSessionId;
  int? index;
  String? objectType;

  Photos({this.id, this.createdTime, this.ownerId, this.type, this.name, this.description, this.url, this.mediaUploadSessionId, this.index, this.objectType});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    ownerId = json['ownerId'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    mediaUploadSessionId = json['mediaUploadSessionId'];
    index = json['index'];
    objectType = json['objectType'];
  }
}

class OrgParameter {
  String? id;
  String? fullname;
  String? username;
  ProfilePhoto? profilePhoto;
  bool? verified;
  bool? followed;
  bool? enableDonate;
  bool? blocked;
  String? gender;
  bool? showFrame;
  String? framePhoto;
  bool? defaultProfilePhoto;
  bool? defaultBannerPhoto;
  String? createdTime;
  String? userType;
  int? countDonate;
  int? countLike;
  int? amount;
  String? donateTargetId;
  int? rank;
  int? totalDonate;
  int? totalDonator;
  int? reward;
  int? totalMoney;
  int? totalOrg;
  ProfilePhoto? bannerPhoto;
  int? receivedMoney;
  String? biography;
  int? notedMoney;
  int? totalCompanion;
  bool? adminChat;
  bool? incognito;

  OrgParameter(
      {this.id,
      this.fullname,
      this.username,
      this.profilePhoto,
      this.verified,
      this.followed,
      this.enableDonate,
      this.blocked,
      this.gender,
      this.showFrame,
      this.framePhoto,
      this.defaultProfilePhoto,
      this.defaultBannerPhoto,
      this.createdTime,
      this.userType,
      this.countDonate,
      this.countLike,
      this.amount,
      this.donateTargetId,
      this.rank,
      this.totalDonate,
      this.totalDonator,
      this.reward,
      this.totalMoney,
      this.totalOrg,
      this.bannerPhoto,
      this.receivedMoney,
      this.biography,
      this.notedMoney,
      this.totalCompanion,
      this.adminChat,
      this.incognito});

  OrgParameter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    profilePhoto = json['profilePhoto'] != null ? ProfilePhoto.fromJson(json['profilePhoto']) : null;
    verified = json['verified'];
    followed = json['followed'];
    enableDonate = json['enableDonate'];
    blocked = json['blocked'];
    gender = json['gender'];
    showFrame = json['showFrame'];
    framePhoto = json['framePhoto'];
    defaultProfilePhoto = json['defaultProfilePhoto'];
    defaultBannerPhoto = json['defaultBannerPhoto'];
    createdTime = json['createdTime'];
    userType = json['userType'];
    countDonate = json['countDonate'];
    countLike = json['countLike'];
    amount = json['amount'];
    donateTargetId = json['donateTargetId'];
    rank = json['rank'];
    totalDonate = json['totalDonate'];
    totalDonator = json['totalDonator'];
    reward = json['reward'];
    totalMoney = json['totalMoney'];
    totalOrg = json['totalOrg'];
    bannerPhoto = json['bannerPhoto'] != null ? ProfilePhoto.fromJson(json['bannerPhoto']) : null;
    receivedMoney = json['receivedMoney'];
    biography = json['biography'];
    notedMoney = json['notedMoney'];
    totalCompanion = json['totalCompanion'];
    adminChat = json['adminChat'];
    incognito = json['incognito'];
  }
}

class ProfilePhoto {
  Small? small;
  Small? medium;
  Small? large;

  ProfilePhoto({this.small, this.medium, this.large});

  ProfilePhoto.fromJson(Map<String, dynamic> json) {
    small = json['small'] != null ? Small.fromJson(json['small']) : null;
    medium = json['medium'] != null ? Small.fromJson(json['medium']) : null;
    large = json['large'] != null ? Small.fromJson(json['large']) : null;
  }
}

class Small {
  String? url;
  Dimension? dimension;

  Small({this.url, this.dimension});

  Small.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    dimension = json['dimension'] != null ? Dimension.fromJson(json['dimension']) : null;
  }
}

class Dimension {
  int? width;
  int? height;

  Dimension({this.width, this.height});

  Dimension.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }
}

class ReleaseModel {
  String? id;
  String? createdTime;
  String? ownerId;
  String? type;
  String? name;
  String? description;
  String? url;
  String? mediaUploadSessionId;
  int? index;
  String? objectType;

  ReleaseModel(
      {this.id, this.createdTime, this.ownerId, this.type, this.name, this.description, this.url, this.mediaUploadSessionId, this.index, this.objectType});

  ReleaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    ownerId = json['ownerId'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    mediaUploadSessionId = json['mediaUploadSessionId'];
    index = json['index'];
    objectType = json['objectType'];
  }
}
