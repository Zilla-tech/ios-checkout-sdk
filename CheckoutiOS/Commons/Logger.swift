import Foundation

class Logger {
    
    private init(){}
    
    public static func log(_ items: Any...) {
        // Only allowing in DEBUG mode
        #if DEBUG
            debugPrint(items)
        #endif
    }
}
