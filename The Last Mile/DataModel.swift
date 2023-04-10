//
//  DataModel.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 19/02/23.
//

import Foundation


struct LeaderBoard {
    var rank : Int
    var userName : String
    var credits : Int
}



//    STORING INFO ABOUT THE USER
struct Profile {
    var profileName: String
    var profileImg: String
    var credits : Int
    var addresses: [Addresses]
    var request: [Request]
    var delivery: [Request]
    var ongoing: [Request]
}



struct Addresses {
    var locationType: String
    var houseAddress: String
    var streetName: String
    var area: String
    var city: String
    var pincode: String
}


struct Request {
    var address: String
    var name: String
    var userImg: String
    var status: String
    var pickupPoint: String
    var trackingId: String
    var deliveryPartnerContactNumber: String
    var deliveryPartnerName: String
    var date: String
    var time: String
    var packageSize: String
    var societyDeliveryPersonName: String
    var societyDeliveryPersonNumber: String
}

enum RequestStatus: String {
    case onRequest
    case onDelivered
    case onAccept
}

struct Delivery {
    var request: Request
    var timestamp : Double
}

//let requests = requestDict.map{dict -> [String:Any] in
//
//    if dict["trackingId"] != delivery1.trackingId{
//        return dict
//    }else{
//        return [
//            "address" : dict["address"],
//            "name" : dict["name"],
//            "userImg" : dict["userImg"],
//            "status" : RequestStatus.onAccept.rawValue,
//            "pickupPoint" : dict["pickupPoint"],
//            "trackingId" : dict["trackingId"],
//            "deliveryPartnerContactNumber" : dict["deliveryPartnerContactNumber"],
//            "deliveryPartnerName" : dict["deliveryPartnerName"],
//            "date" : dict["date"],
//            "time" : dict["time"],
//            "packageSize" : dict["packageSize"],
//            "societyDeliveryPersonName" : DataManagar.userProfile.profileName,
//            "societyDeliveryPersonNumber" : "787878787877"
//        ]
//    }
//}
