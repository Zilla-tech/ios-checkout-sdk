import Foundation

public struct TransactionParams {
    let amount: Int
    let title: String
    let productCategory: String
    let redirectUrl: String
    let clientOrderReference: String
    let type: String
    
    func toDictionary() -> [String: Any] {
        var jsonDict = [String: Any]()
        jsonDict["amount"] = amount
        jsonDict["title"] = title
        jsonDict["productCategory"] = productCategory
        jsonDict["redirectUrl"] = redirectUrl
        jsonDict["clientOrderReference"] = clientOrderReference
        jsonDict["type"] = type

        return jsonDict
    }
}

public class TransactionParamsBuilder {
    
    public private(set) var amount: Int = 0
    public private(set) var title: String = ""
    public private(set) var productCategory: String = ""
    public private(set) var redirectUrl: String = ""
    public private(set) var clientOrderReference: String = ""
    public private(set) var type: String = ""
    
    public init() {}
    
    @discardableResult
    public func amount(_ amount: Int) -> TransactionParamsBuilder {
        self.amount = amount
        return self
    }
    
    @discardableResult
    public func title(_ title: String) -> TransactionParamsBuilder {
        self.title = title
        return self
    }
    
    public func productCategory(_ productCategory: String) -> TransactionParamsBuilder {
        self.productCategory = productCategory
        return self
    }
    
    public func redirectUrl(_ redirectUrl: String) -> TransactionParamsBuilder {
        self.redirectUrl = redirectUrl
        return self
    }
    
    public func clientOrderReference(_ clientOrderReference: String) -> TransactionParamsBuilder {
        self.clientOrderReference = clientOrderReference
        return self
    }
    
    public func type(_ type: String) -> TransactionParamsBuilder {
        self.type = type
        return self
    }
    
    public func build() -> TransactionParams {
        return TransactionParams(amount: self.amount,
                                 title: self.title,
                                 productCategory: self.productCategory,
                                 redirectUrl: self.redirectUrl,
                                 clientOrderReference: self.clientOrderReference,
                                 type: self.type)
    }
}
