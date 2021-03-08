//
//  KKeychainPass.swift
//  keychainf
//
//  Created by developer on 8.03.2021.
//

import UIKit
import Security

class KKeychainOptions {
   static let kSecClassValue = NSString(format: kSecClass)
   static let kSecAccessValue = NSString(format: kSecAttrAccessible)
   static let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
   static let kSecValueDataValue = NSString(format: kSecValueData)
   static let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
   static let kSecAttrServiceValue = NSString(format: kSecAttrService)
   static let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
   static let kSecReturnDataValue = NSString(format: kSecReturnData)
   static let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
}

class KKeychainPass: NSObject {

    class func save(service: String, name:String, data: String) {
        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [KKeychainOptions.kSecClassGenericPasswordValue, service, name, dataFromString], forKeys: [KKeychainOptions.kSecClassValue, KKeychainOptions.kSecAttrServiceValue, KKeychainOptions.kSecAttrAccountValue, KKeychainOptions.kSecValueDataValue])
        
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
         
            if (status != errSecSuccess) {
                fatalError("Keychain save error")
            }
        }
    }
    
    class func load(service: String, name:String) -> String? {
 
        let keychainQuery: NSMutableDictionary = KKeychainPass.getMutableDictionary(service,name)
        
        var dataTypeRef :AnyObject?

        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Error Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
    class func update(service: String, name:String, data: String) {
        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = KKeychainPass.getMutableDictionary(service,name)
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, [KKeychainOptions.kSecValueDataValue:dataFromString] as CFDictionary)
            
            if (status != errSecSuccess) {
                fatalError("Keychain update error")
            }
        }
    }
    
    class func remove(service: String, name:String) {
        
        let keychainQuery: NSMutableDictionary = KKeychainPass.getMutableDictionary(service,name)
    
        let status = SecItemDelete(keychainQuery as CFDictionary)
        
        if (status != errSecSuccess) {
            fatalError("Keychain remove error")
        }
    }
    
    class func clear() {
        
        let keychainQuery:[String:Any] = [KKeychainOptions.kSecClassValue as String: KKeychainOptions.kSecClassGenericPasswordValue]
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        
        if (status != errSecSuccess) {
            fatalError("Keychain clear error")
        }
    }
    
    private class func getMutableDictionary(_ service:String, _ name:String) -> NSMutableDictionary {
        return NSMutableDictionary(objects: [KKeychainOptions.kSecClassGenericPasswordValue, service, name, kCFBooleanTrue!, KKeychainOptions.kSecMatchLimitOneValue], forKeys: [KKeychainOptions.kSecClassValue, KKeychainOptions.kSecAttrServiceValue, KKeychainOptions.kSecAttrAccountValue, KKeychainOptions.kSecReturnDataValue, KKeychainOptions.kSecMatchLimitValue])
    }
}
