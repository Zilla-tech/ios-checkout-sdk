import Foundation

public typealias SuccessHandler = (_ transactionResult: TransactionResult) -> Void

public typealias OnCloseHandler = () -> Void

public typealias EventHandler = (_ eventName: String,_ data: [String: Any]) -> Void
