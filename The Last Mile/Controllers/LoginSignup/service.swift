//
//  service.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 28/03/23.
//

import UIKit

class Service{
    
    static func createAlertController(title: String, message: String)-> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
        
        alert.addAction(okAction)
        
        return alert
    }
    
    
    static func parseIncomingBulletinRequest(_ key: String, _ data:[String: Any])->Delivery?{
        
        if let deliveryPersonName = data["deliveryPersonName"] as? String,
        let timestamp = data["timestamp"] as? Double,
        
        let requestDict = data["request"] as? [String: Any],
        
        let address = requestDict["address"] as? String,
        let name = requestDict["name"] as? String,
        let date = requestDict["date"] as? String,
        let deliveryPartnerContactNumber = requestDict["deliveryPartnerContactNumber"] as? String,
        let deliveryPartnerName = requestDict["deliveryPartnerName"] as? String,
        let time = requestDict["time"] as? String,
        let status = requestDict["status"] as? String,
        let pickupPoint = requestDict["pickupPoint"] as? String,
        let packageSize = requestDict["packageSize"] as? String,
        let trackingId = requestDict["trackingId"] as? String,
        let userImg = requestDict["userImg"] as? String{
            
            let delivery = Delivery(
                request: Request(
                    address: address,
                    name: name,
                    userImg: userImg,
                    status: status,
                    pickupPoint: pickupPoint,
                    trackingId: trackingId,
                    deliveryPartnerContactNumber: deliveryPartnerContactNumber,
                    deliveryPartnerName: deliveryPartnerName,
                    date: date,
                    time: time,
                    packageSize: packageSize
                ),
                deliveryPersonName: deliveryPersonName,
                timestamp: timestamp
            )
            
            return delivery
        }
        
        return nil
    }
    
}
