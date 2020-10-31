//
//  CommunicationManager.swift
//  CoreDataStack
//
//  Created by Bipin Kumar on 17/08/16.
//  Copyright © 2016 Prabhat Kasera. All rights reserved.
//

import UIKit
import MobileCoreServices

class CommunicationManager: NSObject {
 
    let notificationName = Notification.Name("login")
    let defaults = UserDefaults.standard
    
    // MARK: - GET/Json
    func getResponseFor(strUrl : String, parameters: NSDictionary? , completion:@escaping (_ result: String, _ data : AnyObject)->()) {
        
        let request = NSMutableURLRequest(url: URL(string: strUrl)!)
        request.httpMethod = "GET"
       // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "VOTIVE")

        if parameters != nil {
            var data : Data?
            do {
                data = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions(rawValue: 0))
                request.httpBody = data
            } catch {
                data = Data()
            }
        }
        self.callWebservice(request as URLRequest?) { (responseData) in
            
            DispatchQueue.main.async(execute: {
                if responseData is NSDictionary {
                    // handle data here1
                    if  responseData["status"] != nil {
                        
                        let status = String(describing: responseData["status"] as AnyObject).lowercased()
                        
                        if status == "success" || status == "true" || status == "1"  {
                            completion("success", responseData as AnyObject)
                        }
                        else if status == "failed" || status == "false" || status == "0" {
                            if responseData["msg"] as? String != nil{
                                completion("error", responseData as AnyObject)
                            }
                        }
                    } else {
                        //call back else case
                        completion("Network", "Something went wrong." as AnyObject)
                    }
                }
            })
        }
    }

    
    // MARK: - Get/ Query param
    func getResponseForQueryParam(StrUrl : String, parameters: String, completion:@escaping (_ result: String, _ data : AnyObject)->()) {
        
        var serviceStr = "\(StrUrl)\(parameters)"
        serviceStr = serviceStr.replacingOccurrences(of: " ", with: "%20")

        
        let request = NSMutableURLRequest(url: URL(string: serviceStr)!)
        request.httpMethod = "GET"
       // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "VOTIVE")
        
        //let secretKey = SharedPreference.authToken()
        //        if AppTheme.getIsUserLogin() {
        //            let secretKey = AppTheme.getSecretKey()
        //request.setValue(secretKey, forHTTPHeaderField: "authorization")
        //        }

        
        self.callWebservice(request as URLRequest?) { (responseData) in
            
            DispatchQueue.main.async(execute: {
                if responseData is NSDictionary {
                    // handle data here1
                    if  responseData["status"] != nil {
                        
                        let status = String(describing: responseData["status"] as AnyObject).lowercased()
                        
                        if status == "success" || status == "true" {
                            completion("success", responseData as AnyObject)
                        } else if status == "1001" {
                            print("Version Update")
                            //AppTheme.versionUpdated()
                        } else if status == "failed" || status == "false" || status == "0" {
                            
                            if let responceMsg : NSError = responseData["message"] as? NSError {
                                let data : NSMutableDictionary = responseData as! NSMutableDictionary
                                data["message"] = responceMsg.localizedDescription
                                
                                completion("error", data as AnyObject)
                            } else {
                                
                                if responseData["message"] as! String == "Invalid Token" {
                                   // AppTheme.tokenExpired()
                                } else {
                                    completion("error", responseData as AnyObject)
                                }
                            }
                        }
                    } else {
                        //call back else case
                        completion("error", "Something went wrong." as AnyObject)
                    }
                }
            })
        }
    }
    
    
    
    // MARK: - Post/Json
    func getResponseForPost(strUrl : String, parameters: NSDictionary? , completion:@escaping (_ result: String, _ data : AnyObject)->()) {
        
        let request = NSMutableURLRequest(url: URL(string: strUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "VOTIVE")
    
        if parameters != nil {
            var data : Data?
            do {
                data = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions(rawValue: 0))
                request.httpBody = data
            } catch {
                data = Data()
            }
        }
        self.callWebservice(request as URLRequest?) { (responseData) in
            
            DispatchQueue.main.async(execute: {
                if responseData is NSDictionary {
                    // handle data here1
                    print(responseData)
                    if  responseData["status"] != nil {
                        
                        let status = String(describing: responseData["status"] as AnyObject).lowercased()
                        
                        if status == "success" || status == "true" || status == "1" || status == "y"  {
                            completion("success", responseData as AnyObject)
                        }
                        else if status == "failed" || status == "false" || status == "0" || status == "n"  {
                            if (responseData["result"] as! NSDictionary)["msg"] as? String != nil{
                                 completion("error", responseData as AnyObject)
                            }
                        }
                    } else {
                        //call back else case
                        completion("Network", "Something went wrong." as AnyObject)
                    }
                }
            })
        }
    }
    
    // MARK: - Post/Param
    func getResponseForParamType(strUrl : String, parameters: NSDictionary?, completion:@escaping (_ result: String, _ data : AnyObject)->()) {
        
        let body = NSMutableData()
        let request = NSMutableURLRequest(url: NSURL(string: strUrl)! as URL)
        request.httpMethod = "POST";
        
        let boundary = generateBoundaryString()
        //define the multipart request type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "VOTIVE")
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(Data( "--\(boundary)\r\n".utf8))
                body.append(Data( "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data( "\(value)\r\n".utf8))
            }
        }
        body.append(Data( "--\(boundary)--\r\n".utf8))
        request.httpBody = body as Data
        
        self.callWebservice(request as URLRequest?) { (responseData) in
            DispatchQueue.main.async(execute: {
                if responseData is NSDictionary {
                    // handle data here1
                    print(responseData)
                    if  responseData["status"] != nil {
                        
                        let status = String(describing: responseData["status"] as AnyObject).lowercased()
                        
                        if status == "success" || status == "true" || status == "1" || status == "y"  {
                            completion("success", responseData as AnyObject)
                        }
                        else if status == "failed" || status == "false" || status == "0" || status == "n"  {
                            if responseData["msg"] as? String != nil{
                                completion("error", responseData as AnyObject)
                            }
                        }
                    } else {
                        //call back else case
                        completion("Network", "Something went wrong." as AnyObject)
                    }
                } else {
                    //call back else case
                    completion("Network", "Something went wrong." as AnyObject)
                }
            })
        }
    }
    
    // MARK: - Post/Param (Multipart- Image)
    //My function for sending data with image
    func getResponseForMultipartType(strUrl : String, parameters: NSDictionary?, imagesData : [Data], imageKey: String , check : String,  completion:@escaping (_ result: String, _ data : AnyObject)->()) {
        //filePath
        let request = NSMutableURLRequest(url: NSURL(string: strUrl)! as URL)
        request.httpMethod = "POST";
      //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("123456", forHTTPHeaderField: "VOTIVE")
        
        let boundary = generateBoundaryString()
        //define the multipart request type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBodyWithParameters(parameters: parameters, imageKey: imageKey , imageData: imagesData , boundary: boundary, check : check) as Data
        self.callWebservice(request as URLRequest?) { (responseData) in
            
            DispatchQueue.main.async(execute: {
                if responseData is NSDictionary {
                    // handle data here1
                    if  responseData["status"] != nil {
                        
                        let status = String(describing: responseData["status"] as AnyObject).lowercased()
                        
                        if status == "success" || status == "true" || status == "1"  {
                            completion("success", responseData as AnyObject)
                        }
                        else if status == "failed" || status == "false" || status == "0" {
                            if responseData["msg"] as? String != nil{
                                completion("error", responseData as AnyObject)
                            }
                        }
                    } else {
                        //call back else case
                        completion("Network", "Something went wrong." as AnyObject)
                    }
                } else {
                    //call back else case
                    completion("Network", "Something went wrong." as AnyObject)
                }
            })
            
        }
    }
    
    func createBodyWithParameters(parameters: NSDictionary?, imageKey: String, imageData: [Data], boundary: String, check : String) -> NSData {
        
        let body = NSMutableData();
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(value)\r\n".utf8))
            }
        }
        
    
        var name = ""
        if !imageData.isEmpty {
            for i in 0...imageData.count-1 {
                if !imageData[i].isEmpty {
                    let filename = "user-profile\(i).jpg"
                    let mimetype = "image/jpg"
                    name = imageKey
                    
                    
//                    if check == "CreateOrder"{
//                        name = imageKey
//                    }else if check == "Receipt"{
//                        name = imageKey
//                    }else{
//                        name = "photo[\(i)]"
//                    }
                    
                    body.append(Data( "--\(boundary)\r\n".utf8))
                    body.append(Data( "Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".utf8))
                    body.append(Data( "Content-Type: \(mimetype)\r\n\r\n".utf8))
                    body.append(imageData[i] as Data)
                    body.append(Data( "\r\n".utf8))
                    body.append(Data( "--\(boundary)--\r\n".utf8))
                }
            }
        }
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    
    func downloadImage(fromURL: URL,completion:@escaping (_ responseData : AnyObject) -> ()) {
        let task = URLSession.shared.dataTask(with: fromURL, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                let errorDictionary = NSMutableDictionary()
              //  errorDictionary.setValue("0", forKey: WebServiceKey.Status.rawValue)
               // errorDictionary.setValue(error!.localizedDescription, forKey: WebServiceKey.Message.rawValue)
                completion(errorDictionary)
            } else {
                completion(data as AnyObject)
            }
        })
        task.resume()
    }
    
   
    func callWebservice(_ request: URLRequest!, completion:@escaping (_ responseData : NSDictionary) -> ()) {
        
        let task = URLSession.shared
            .dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if (error != nil) {
                    print(error!.localizedDescription)
                    let errorDictionary = NSMutableDictionary()
                    completion(errorDictionary)
                } else {
                    do {
                        let parsedJSON = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments)//(rawValue: 0))
                        completion((parsedJSON as AnyObject) as! NSDictionary)
                    } catch let JSONError as NSError {
                        let errorDictionary = NSMutableDictionary()
                        print(JSONError)
                        completion(errorDictionary)
                    }
                }
            })
        task.resume()
    }
    
    func showAlert(title:String , message : String , cancelButtonTitle:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
