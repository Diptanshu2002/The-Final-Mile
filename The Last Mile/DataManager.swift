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
        delivery: []
    )
    
    static var Bulletin = [
        Delivery(
            request: Request(
                address: "Sannasi Hostel, SRM",
                name: "Rohan Singh",
                userImg: "profileImage",
                status: "",
                pickupPoint: "SRM Main Gate",
                trackingId: "#2139382903823",
                deliveryPartnerContactNumber: "6290607898",
                deliveryPartnerName: "zomato",
                date: "October 8, 2016",
                time: "10:52:30",
                packageSize: "Medium"
            ),
            deliveryPersonName: ""
        )
    ]
    
    
    
    
    static func UploadUserDetailsToDatabase(email: String, name: String, onSuccess: @escaping ()-> Void){
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let userProfileDict: [String: Any] = ["profileName": name,
                                              "profileImg": "profileImage",
                                              "credits": 0,
                                              "addresses": [],
                                              "request": [],
                                              "delivery": []]
        ref.child("users").child(uid!).setValue(userProfileDict)
        onSuccess()
    }
    
    static func GetUserDetailsFromDatabase(onSuccess: @escaping ()-> Void, OnError: @escaping (_ error: Error?) -> Void){
        let ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        ref.child("users").child(uid).observe(.value) { snapshot  in
            
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
                        packageSize: dict["packageSize"] as? String ?? ""
                    )
                }
                
                let userProfile = Profile(
                    profileName: profileName,
                    profileImg: profileImg,
                    credits: credits,
                    addresses: addresses,
                    request: requests,
                    delivery: []
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
        print("added request", DataManagar.userProfile.request)
        
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
            "packageSize": newRequest.packageSize
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
        let Allrequest = [
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
            "packageSize": newRequest.packageSize
        ]
        
        ref.child("allRequests").setValue(Allrequest)
        return true
    }
    
    
    
    public func postNewAddress(newAddress: Addresses) -> Bool {
        DataManagar.userProfile.addresses.append(newAddress)
        print("added address", DataManagar.userProfile.addresses)
        return true
    }
    
    public func getAddresses()->[Addresses]{
        return DataManagar.userProfile.addresses
    }
    
    
    
    public func getBulletin() -> [Delivery] {
        return DataManagar.Bulletin
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
