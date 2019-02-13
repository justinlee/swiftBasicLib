import Foundation
import Alamofire
import InterparkPushLib_iOS

/*
 public enum HTTPMethod: String {
 case options = "OPTIONS"
 case get     = "GET"
 case head    = "HEAD"
 case post    = "POST"
 case put     = "PUT"
 case patch   = "PATCH"
 case delete  = "DELETE"
 case trace   = "TRACE"
 case connect = "CONNECT"
 }
 */

struct NetworkHelper:NetworkHelperProtocol {
    
    func jsonRequest(path: String, method: HTTPMethod = .post,params: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (String) -> Void) {
        
        let response:(DataResponse<Any>) -> Void = { response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                if let json = response.result.value {
                    print(json)
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    completion(utf8Text)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        switch method {
        case .options :
            Alamofire.request(path, method: .options , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .head    :
            Alamofire.request(path, method: .head , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .post    :
            Alamofire.request(path, method: .post , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .put     :
            Alamofire.request(path, method: .put , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .patch   :
            Alamofire.request(path, method: .patch , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .delete  :
            Alamofire.request(path, method: .delete , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .trace   :
            Alamofire.request(path, method: .trace , parameters:params, headers: headers).responseJSON(completionHandler: response)
        case .connect :
            Alamofire.request(path, method: .connect , parameters:params, headers: headers).responseJSON(completionHandler: response)
        default:
            Alamofire.request(path, method: .get , parameters:params, headers: headers).responseJSON(completionHandler: response)
        }
        
        /*
         Alamofire.request(path, method: .get , parameters:params, headers: headers).responseJSON { response in
         debugPrint(response)
         
         if let json = response.result.value {
         print(json)
         }
         
         if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
         print("Data: \(utf8Text)") // original server data as UTF8 string
         completion(utf8Text)
         }
         }
         */
        
        
    }
    
    func dataRequest(path: String, method: HTTPMethod, headers: [String: String]? = nil, completion: @escaping (_ data:Data) -> Void) {
        Alamofire.download(path).responseData { response in
            if let data = response.result.value {
                
                //let image = UIImage(data: data)
                completion(data)
            }
        }
    }
}

