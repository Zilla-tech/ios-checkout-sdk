import Foundation

public struct CreateWithPublicKeyResponse : Decodable {
    let message: String?
    let data: CreateWithPublicKeyInfo?
}

struct CreateWithPublicKeyInfo: Decodable {
    let amount: Int?
    let clientOrderReference: String?
    let completedAt: String?
    let createdAt: String?
    let createdByPrincipalId: String?
    let customerHandle: String?
    let customerId: String?
    let id: String?
    let merchantOutletId: String?
    let orderCode: String?
    let orderSource: String?
    let paymentLink: String?
    let productCategory: String?
    let redirectUrl: String?
    let reusableCount: Int?
    let status: String?
    let title: String?
    let type: String?
    let usedCount: Int?
}
