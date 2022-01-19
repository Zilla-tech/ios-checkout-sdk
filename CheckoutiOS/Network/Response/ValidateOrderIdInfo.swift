import Foundation

public struct ValidateOrderIdResponse : Decodable {
    let message: String?
    let data: ValidateOrderIdInfo?
}

struct ValidateOrderIdInfo: Decodable {
    let paymentLink: String?
    let redirectUrl: String?
    let letidForPayment: Bool?
}
