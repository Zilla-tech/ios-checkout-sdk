import Foundation

struct ApiEndPoints {
    
    static func createWithPublicKey() -> String {
        return "\(ApiConstants.BaseUrl)/sdk/bnpl/purchase-order/create-with-pk"
    }
    
    static func validateOrderId(_ orderId: String) -> String {
        return "\(ApiConstants.BaseUrl)/sdk/bnpl/purchase-order/\(orderId)/valid-for-payment"
    }
}
