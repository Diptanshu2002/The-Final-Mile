//
//  DataManager.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 16/03/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataManagar {
    static let shared = DataManagar()
    
    static var userProfile = Profile(
        profileName: "",
        profileImg: "profileImage",
        credits: 0,
        addresses: [],
        request: [],
        delivery: [],
        ongoing: []
    )
    
    static var Bulletin : [Delivery] = [

    ]
    
    static var OngoingDelivery: [Request] = []
    
    
    //MARK: VARIABLES
    
    
    
    //MARK: DATABASE REFERENCES
    static var bulletinRef:DatabaseReference {
        return Database.database().reference().child("allRequests")
    }
    
    //MARK: NEED TO CHECK THE LOGIC
    static var oldBulletinQuery: DatabaseQuery {
        
        var queryRef:DatabaseQuery
        let lastBulletin = DataManagar.Bulletin.last
        if lastBulletin != nil {
            let lastTimestamp = lastBulletin!.timestamp
            queryRef = bulletinRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp)
        }else{
            queryRef = bulletinRef.queryOrdered(byChild: "timestamp")
        }
        return queryRef
    }
    
    
    static var newBulletinQuery: DatabaseQuery {
        var queryRef:DatabaseQuery
        let firstBulletin = DataManagar.Bulletin.first
        if firstBulletin != nil {
            let firstTimestamp = firstBulletin!.timestamp
            queryRef = bulletinRef.queryOrdered(byChild: "timestamp").queryStarting(atValue: firstTimestamp)
        }else{
            queryRef = bulletinRef.queryOrdered(byChild: "timestamp")
        }
        return queryRef
    }
    
    
    
    
    
    //MARK: DATABASE UPDATES FUNCTIONS
    static func UploadUserDetailsToDatabase(email: String, name: String, onSuccess: @escaping ()-> Void){
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let userProfileDict: [String: Any] = ["profileName": name,
                                              "profileImg": "profileImage",
                                              "credits": 0,
                                              "addresses": [],
                                              "request": [],
                                              "delivery": [],
                                              "ongoing":[]
        ]
        ref.child("users").child(uid!).setValue(userProfileDict)
        onSuccess()
    }
    
    
    static func GetUserDetailsFromDatabase(onSuccess: @escaping ()-> Void, OnError: @escaping (_ error: Error?) -> Void){
        let ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        ref.child("users").child(uid).observe(.value) { snapshot   in
            
            if let userDict = snapshot.value as? [String: Any]{
                
                let profileName = userDict["profileName"] as? String ?? ""
                let profileImg = userDict["profileImg"] as? String ?? ""
                let credits = userDict["credits"] as? Int ?? 0
                
                
                let addrDict  = userDict["addresses"] as? [[String: Any]] ?? []
                let addresses = addrDict.map{ dict -> Addresses in
                    return Addresses(
                        locationType: dict["locationType"] as? String ?? "",
                        houseAddress: dict["houseAddress"] as? String ?? "",
                        streetName: dict["streetName"] as? String ?? "",
                        area: dict["area"] as? String ?? "",
                        city: dict["city"] as? String ?? "",
                        pincode: dict["pincode"] as? String ?? "")
                }
                
                
                let requestDict = userDict["request"] as? [[String:Any]] ?? []
                let requests = requestDict.map{dict -> Request in
                    return Request(
                        address: dict["address"] as? String ?? "",
                        name: dict["name"] as? String ?? "",
                        userImg: dict["userImg"] as? String ?? "",
                        status: dict["status"] as? String ?? "",
                        pickupPoint: dict["pickupPoint"] as? String ?? "",
                        trackingId: dict["trackingId"] as? String ?? "",
                        deliveryPartnerContactNumber: dict["deliveryPartnerContactNumber"] as? String ?? "",
                        deliveryPartnerName: dict["deliveryPartnerName"] as? String ?? "",
                        date: dict["date"] as? String ?? "",
                        time: dict["time"] as? String ?? "",
                        packageSize: dict["packageSize"] as? String ?? "",
                        societyDeliveryPersonName: dict["societyDeliveryPersonName"] as? String ?? "",
                        societyDeliveryPersonNumber: dict["societyDeliveryPersonNumber"] as? String ?? ""
                    )
                }
                
                
                
                let ongoingDict = userDict["ongoing"] as? [[String:Any]] ?? []
                let ongoing = ongoingDict.map{dict -> Request in
                    return Request(
                        address: dict["address"] as? String ?? "",
                        name: dict["name"] as? String ?? "",
                        userImg: dict["userImg"] as? String ?? "",
                        status: dict["status"] as? String ?? "",
                        pickupPoint: dict["pickupPoint"] as? String ?? "",
                        trackingId: dict["trackingId"] as? String ?? "",
                        deliveryPartnerContactNumber: dict["deliveryPartnerContactNumber"] as? String ?? "",
                        deliveryPartnerName: dict["deliveryPartnerName"] as? String ?? "",
                        date: dict["date"] as? String ?? "",
                        time: dict["time"] as? String ?? "",
                        packageSize: dict["packageSize"] as? String ?? "",
                        societyDeliveryPersonName: dict["societyDeliveryPersonName"] as? String ?? "",
                        societyDeliveryPersonNumber: dict["societyDeliveryPersonNumber"] as? String ?? ""
                    )
                }
                
                
                
                let userProfile = Profile(
                    profileName: profileName,
                    profileImg: profileImg,
                    credits: credits,
                    addresses: addresses,
                    request: requests,
                    delivery: [],
                    ongoing: ongoing
                )
                
                DataManagar.shared.setUserProfile(userDetails: userProfile)
                print("data from dataBase", userProfile)
            }
            
        } withCancel: { error in
            OnError(error)
        }
        
        
    }
    
    
    //Storing the retrived data from database to the Profile Struct
    public func setUserProfile(userDetails: Profile) {
        
        DataManagar.userProfile = userDetails
    }
    
    // Getting the User Details from the Profile Struct
    public func getUserProfile() -> Profile{
        return DataManagar.userProfile
    }
    
    
    //Getting the User Request From the Profile Struct Request Attribute
    public func getUserRequest() -> [Request] {
        return DataManagar.userProfile.request
    }

    
    
    
    
    
    
    // add request to the request and append it to the request of the user
    public func postNewRequest(newRequest: Request) -> Bool{
        DataManagar.userProfile.request.append(newRequest)
//        print("added request", DataManagar.userProfile.request)
        
        let request = [
            "address": newRequest.address,
            "name": newRequest.name,
            "userImg": "profileImage",
            "status": newRequest.status,
            "pickupPoint": newRequest.pickupPoint,
            "trackingId": newRequest.trackingId,
            "deliveryPartnerContactNumber": newRequest.deliveryPartnerContactNumber,
            "deliveryPartnerName": newRequest.deliveryPartnerName,
            "date": newRequest.date,
            "time": newRequest.time,
            "packageSize": newRequest.packageSize,
            "societyDeliveryPersonName" : newRequest.societyDeliveryPersonName,
            "societyDeliveryPersonNumber" : newRequest.societyDeliveryPersonNumber
        ]
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value) { snapshot in
            if let userDict = snapshot.value as? [String: Any]{
                let requestDict = userDict["request"] as? [[String: Any]] ?? []
                var newRequestDict = requestDict
                newRequestDict.append(request)
                
                ref.child("users").child(uid!).updateChildValues([
                    "request" : newRequestDict
                ])
            }
        }
        
        
        //Uploading the request to make it allRequest path in database
        
        let Delivery = [
            "request": [
                "uid": uid!,
                "address": newRequest.address,
                "name": newRequest.name,
                "userImg": "profileImage",
                "status": newRequest.status,
                "pickupPoint": newRequest.pickupPoint,
                "trackingId": newRequest.trackingId,
                "deliveryPartnerContactNumber": newRequest.deliveryPartnerContactNumber,
                "deliveryPartnerName": newRequest.deliveryPartnerName,
                "date": newRequest.date,
                "time": newRequest.time,
                "packageSize": newRequest.packageSize,
                "societyDeliveryPersonName" : newRequest.societyDeliveryPersonName,
                "societyDeliveryPersonNumber" : newRequest.societyDeliveryPersonNumber
            ],
            "timestamp" : [".sv" : "timestamp"]
        ] as [String : Any]
        
        ref.child("allRequests").childByAutoId().setValue(Delivery)
        
        return true
    }
    
    
    
    public func postNewAddress(newAddress: Addresses) -> Bool {
        DataManagar.userProfile.addresses.append(newAddress)
//        print("added address", DataManagar.userProfile.addresses)
        return true
    }
    
    public func getAddresses()->[Addresses]{
        return DataManagar.userProfile.addresses
    }
    
    
    
    static func getBulletinDataFromDatabase(onSuccess: @escaping ()-> Void, OnError: @escaping (_ error: Error?) -> Void){
        
        let ref = DataManagar.bulletinRef
        let queryRef = DataManagar.oldBulletinQuery
        
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        //        queryRef.queryLimited(toLast: 20).observeSingleEvent
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            var tempBulletin = [Delivery]()
            
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String : Any],
                   let delivery = Service.parseIncomingBulletinRequest(childSnapshot.key, dict)
                {
                    tempBulletin.insert(delivery, at: 0)
                    DataManagar.Bulletin = tempBulletin
                    print("Deliveried : ", DataManagar.Bulletin)
                    onSuccess()
                }
            }
            //write completion statement here
        })
    }
    
    
    
    
    static func getBulletinLatestDataFromDatabase(onSuccess: @escaping ()-> Void){
        
        let ref = DataManagar.bulletinRef
        let queryRef = DataManagar.newBulletinQuery
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            var tempBulletin = [Delivery]()
            let firstPost = DataManagar.Bulletin.first
            
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String : Any],
                   let delivery = Service.parseIncomingBulletinRequest(childSnapshot.key, dict)
                {
                    tempBulletin.insert(delivery, at: 0)
                    DataManagar.Bulletin = tempBulletin
                    print("Deliveried : ", DataManagar.Bulletin)
                    onSuccess()
                }
            }
            //write completion statement here
        })
    }
    
    
    
    
    
    public func getBulletin() -> [Delivery] {
        return DataManagar.Bulletin
    }
    
    
    public func deleteBulletin(index: String) -> Void {
        
        DataManagar.Bulletin.removeAll { delivery in
            delivery.request.trackingId == index
        }
        print("after removing the new array : ",DataManagar.Bulletin)
    }
    
    
    
    
    
    public func getOngoingDelivery() -> [Request]{
        return DataManagar.OngoingDelivery
    }
    
    public func setOngoingDelivery(delivery1: Request) -> Void{
//        print("setOngoingDelivery",delivery1)
        // 3 main things will change
        
        // 1. delete from all request with timestap as key
        var requestUserUid = ""
        
        Database.database().reference().child("allRequests").observeSingleEvent(of: .value, with: { snapshot in
            
            var tempBulletin = [Request]()
            var data = []
            
            
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String : Any],
                   let requestDict = dict["request"] as? [String: Any],
                   let uid = requestDict["uid"] as? String,
                   let delivery = Service.parseIncomingBulletinRequest(childSnapshot.key, dict)
                {
//                    tempBulletin.insert(delivery, at: 0)
//                    DataManagar.Bulletin = tempBulletin
//                    print("Deliveried : ", DataManagar.Bulletin)
                    if delivery.request.trackingId != delivery1.trackingId{
//                        tempBulletin.insert(delivery, at: 0)
                        
                        let Delivery = [
                            "request": [
                                "uid": uid,
                                "address": delivery.request.address,
                                "name": delivery.request.name,
                                "userImg": "profileImage",
                                "status": delivery.request.status,
                                "pickupPoint": delivery.request.pickupPoint,
                                "trackingId": delivery.request.trackingId,
                                "deliveryPartnerContactNumber": delivery.request.deliveryPartnerContactNumber,
                                "deliveryPartnerName": delivery.request.deliveryPartnerName,
                                "date": delivery.request.date,
                                "time": delivery.request.time,
                                "packageSize": delivery.request.packageSize,
                                "societyDeliveryPersonName" : delivery.request.societyDeliveryPersonName,
                                "societyDeliveryPersonNumber" : delivery.request.societyDeliveryPersonNumber
                            ],
                            "timestamp" : delivery.timestamp
                        ] as [String : Any]
                        
                        data.append(Delivery)
                        
                        
                        // 2. update request in user using user uid and tracking id
                        Database.database().reference().child("users").child(uid).observe(.value) { snapshot  in
                            if var userDict = snapshot.value as? [String: Any]{
                                var requestDict = userDict["request"] as? [[String:Any]] ?? []
                                var requests = requestDict.map{dict -> Request in
                                    return Request(
                                        address: dict["address"] as? String ?? "",
                                        name: dict["name"] as? String ?? "",
                                        userImg: dict["userImg"] as? String ?? "",
                                        status: dict["status"] as? String ?? "",
                                        pickupPoint: dict["pickupPoint"] as? String ?? "",
                                        trackingId: dict["trackingId"] as? String ?? "",
                                        deliveryPartnerContactNumber: dict["deliveryPartnerContactNumber"] as? String ?? "",
                                        deliveryPartnerName: dict["deliveryPartnerName"] as? String ?? "",
                                        date: dict["date"] as? String ?? "",
                                        time: dict["time"] as? String ?? "",
                                        packageSize: dict["packageSize"] as? String ?? "",
                                        societyDeliveryPersonName: dict["societyDeliveryPersonName"] as? String ?? "",
                                        societyDeliveryPersonNumber: dict["societyDeliveryPersonNumber"] as? String ?? ""
                                    )
                                }
                                
                                for request in 0..<requests.count {
                                    if requests[request].trackingId == delivery1.trackingId{
                                        requests[request].status = RequestStatus.onAccept.rawValue
                                        requests[request].societyDeliveryPersonName = DataManagar.userProfile.profileName
                                        requests[request].societyDeliveryPersonNumber = "0000000000"
                                    }
                                }
                                
                                var dict:[[String:Any]] = []
                                for request in requests {
                                    let req = [
                                        "address" : request.address,
                                        "name" : request.name,
                                        "userImg": request.userImg,
                                        "status" : request.status,
                                        "pickupPoint" : request.pickupPoint,
                                        "trackingId" : request.trackingId,
                                        "deliveryPartnerContactNumber" : request.deliveryPartnerContactNumber,
                                        "deliveryPartnerName" : request.deliveryPartnerName,
                                        "date" : request.date,
                                        "time" : request.time,
                                        "packageSize" : request.packageSize,
                                        "societyDeliveryPersonName" : request.societyDeliveryPersonName,
                                        "societyDeliveryPersonNumber" : request.societyDeliveryPersonNumber
                                    ] as [String: Any]
                                    
                                    dict.append(req)
                                }
                                
                                
                                Database.database().reference().child("users").child(uid).updateChildValues([
                                    "request" : dict ])
                                print("updated request check", dict)
                                
                            }
                        }
                        
                        
                        
                        
                    }
                }
            }
            print("check fast",data)
            Database.database().reference().child("allRequests").setValue(data)
            //write completion statement here
        })
        
        //3.  add to ongoing request to the currentUser
        guard let CurUid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let deliver = [
            "address": delivery1.address,
            "name": delivery1.name,
            "userImg": "profileImage",
            "status": delivery1.status,
            "pickupPoint": delivery1.pickupPoint,
            "trackingId": delivery1.trackingId,
            "deliveryPartnerContactNumber": delivery1.deliveryPartnerContactNumber,
            "deliveryPartnerName": delivery1.deliveryPartnerName,
            "date": delivery1.date,
            "time": delivery1.time,
            "packageSize": delivery1.packageSize,
            "societyDeliveryPersonName" : delivery1.societyDeliveryPersonName,
            "societyDeliveryPersonNumber" : delivery1.societyDeliveryPersonNumber
        ]
        
        Database.database().reference().child("users").child(CurUid).observeSingleEvent(of: .value) { snapshot in
            if let userDict = snapshot.value as? [String: Any]{
                let requestDict = userDict["ongoing"] as? [[String: Any]] ?? []
                var newRequestDict = requestDict
                newRequestDict.append(deliver)
                
                Database.database().reference().child("users").child(CurUid).updateChildValues([
                    "ongoing" : newRequestDict
                ])
            }
        }
        

        

//        var userPro = getUserProfile()
//        userPro.ongoing.append(delivery1)
//        setUserProfile(userDetails: userPro)
        
        DataManagar.OngoingDelivery.append(delivery1)
        
        
        
    }
    
    
}
    



// Assuming you have retrieved the dictionary from the Realtime Database and assigned it to a constant named userProfileDict
/*
    let addressesDict = userProfileDict["addresses"] as? [[String: Any]] ?? []
    let addresses = addressesDict.map { dict -> Addresses in
        return Addresses(
            locationType: dict["locationType"] as? String ?? "",
            houseAddress: dict["houseAddress"] as? String ?? "",
            streetName: dict["streetName"] as? String ?? "",
            area: dict["area"] as? String ?? "",
            city: dict["city"] as? String ?? "",
            pincode: dict["pincode"] as? String ?? ""
        )
    }

    let requestDict = userProfileDict["request"] as? [[String: Any]] ?? []
    let request = requestDict.map { dict -> Request in
        return Request(
            address: dict["address"] as? String ?? "",
            name: dict["name"] as? String ?? "",
            userImg: dict["userImg"] as? String ?? "",
            status: dict["status"] as? String ?? RequestStatus.onRequest.rawValue,
            pickupPoint: dict["pickupPoint"] as? String ?? "",
            trackingId: dict["trackingId"] as? String ?? "",
            deliveryPartnerContactNumber: dict["deliveryPartnerContactNumber"] as? String ?? "",
            deliveryPartnerName: dict["deliveryPartnerName"] as? String ?? "",
            date: dict["date"] as? String ?? "",
            time: dict["time"] as? String ?? "",
            packageSize: dict["packageSize"] as? String ?? ""
        )
    }

    let userProfile = UserProfile(
        profileName: userProfileDict["profileName"] as? String ?? "",
        profileImg: userProfileDict["profileImg"] as? String ?? "",
        credits: userProfileDict["credits"] as? Int ?? 0,
        addresses: addresses,
        request: request,
        delivery: []
    )
*/
    


/*
 
 Profile(
     profileName: "Diptanshu Mandal",
     profileImg: "profileImage",
     credits: 100,
     addresses: [
         Addresses(
             locationType: "Hostel",
             houseAddress: "Room No. 204, Sannasi Hostel",
             streetName: "SRM Main Road",
             area: "Potheri",
             city: "Kattankulathur",
             pincode: "603203"),
         
         Addresses(
             locationType: "Office",
                   houseAddress: "T-Block, Abode Valley",
                   streetName: "No Idea",
                   area: "Potheri",
                   city: "Kattankulathur",
                   pincode: "603203"
                  )
     ],
     
     request: [
         Request(
             address: "",
             name: "Diptanshu Mandal",
             userImg: "profileImage",
             status: RequestStatus.onRequest.rawValue,
             pickupPoint: "SRM Arch Gate",
             trackingId: "#2139382903823",
             deliveryPartnerContactNumber: "+916290607898",
             deliveryPartnerName: "amazon",
             date: "October 8, 2016",
             time: "10:52:30",
             packageSize: "Large"
         ),
         Request(
             address: "",
             name: "Diptanshu Mandal",
             userImg: "profileImage",
             status: RequestStatus.onAccept.rawValue,
             pickupPoint: "Infosys Gate No. 1",
             trackingId: "#2139382903823" ,
             deliveryPartnerContactNumber: "+916290607898",
             deliveryPartnerName: "zomato",
             date: "October 8, 2016",
             time: "10:52:30",
             packageSize: "Small"
         )
     ],
     delivery: []
 )
 */
