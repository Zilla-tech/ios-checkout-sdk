import Foundation
import Alamofire

protocol IApiService {
    
    func validateOrderId(publicKey: String, orderId: String,
                         successCompletion: @escaping (_ response: ValidateOrderIdInfo?) -> Void,
                         _ errorCompletion: @escaping (_ error: Error) -> Void)
    
    func createWithPublicKey(publicKey: String, request: TransactionParams,
                             successCompletion: @escaping (_ response: CreateWithPublicKeyInfo?) -> Void,
                             _ errorCompletion: @escaping (_ error: Error) -> Void)
}

class ApiService : IApiService {
    
    static let shared = ApiService()
    
    func validateOrderId(publicKey: String, orderId: String,
                         successCompletion: @escaping (_ response: ValidateOrderIdInfo?) -> Void,
                         _ errorCompletion: @escaping (_ error: Error) -> Void) {
     
        AF.request(ApiEndPoints.validateOrderId(orderId),
                   headers: [ApiConstants.PublicKey : publicKey])
          .validate(statusCode: 200..<300)
          .responseDecodable { (response: DataResponse<ValidateOrderIdResponse, AFError>) in
              
              switch response.result {
                  case .success(let value):
                  guard let data = value.data else {
                      Logger.log("Error occurred: \(String(describing: response.error))")
                      successCompletion(nil)
                      return
                  }
                  successCompletion(data)
                  case .failure(let error):
                      errorCompletion(error)
                      Logger.log(error)
              }
        }
        
    }
    
    func createWithPublicKey(publicKey: String, request: TransactionParams,
                             successCompletion: @escaping (_ response: CreateWithPublicKeyInfo?) -> Void,
                             _ errorCompletion: @escaping (_ error: Error) -> Void) {
        
        AF.request(ApiEndPoints.createWithPublicKey(),
                   method: .post,
                   parameters: request.toDictionary(),
                   encoding: JSONEncoding.default,
                   headers: [ApiConstants.PublicKey : publicKey])
          .validate(statusCode: 200..<300)
          .responseDecodable { (response: DataResponse<CreateWithPublicKeyResponse, AFError>) in
              
              switch response.result {
                  case .success(let value):
                  guard let data = value.data else {
                      Logger.log("Error occurred: \(String(describing: response.error))")
                      successCompletion(nil)
                      return
                  }
                  successCompletion(data)
                  case .failure(let error):
                      errorCompletion(error)
                      Logger.log(error)
              }
        }
    }
    
    
}
