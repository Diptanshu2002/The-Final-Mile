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
    
}

enum RequestStatus: String {
    case onRequest
    case onDelivered
    case onAccept
}

struct Delivery {
    var request: Request
    var deliveryPersonName: String
    var timestamp : Double
}
