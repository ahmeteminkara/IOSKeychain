import Flutter
import UIKit
import Security

public class SwiftIosKeychainPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_keychain", binaryMessenger: registrar.messenger())
    let instance = SwiftIosKeychainPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        
        case "readKey":
            guard let args = call.arguments else {
                return
            }
            if let myArgs = args as? [String: Any],
               let key = myArgs["key"] as? String{
                let value = readKey(key: key)
                result(value)
                
            }else{
                result(nil)
            }
            
            break;
        case "removeKey":
            guard let args = call.arguments else {
                return
            }
            if let myArgs = args as? [String: Any],
               let key = myArgs["key"] as? String{
                removeKey(key: key)
                result(true)
            }else{
                result(nil)
            }
            
            break;
        case "writeKey":
            guard let args = call.arguments else {
                result(false)
                return
            }
            if let myArgs = args as? [String: Any],
               let key = myArgs["key"] as? String,
               let value = myArgs["value"] as? String {
                
                writeKey(key: key, value: value)
                result(true)
            }else{
                result(false)
            }
            
            break;
        case "updateKey":
            guard let args = call.arguments else {
                result(false)
                return
            }
            if let myArgs = args as? [String: Any],
               let key = myArgs["key"] as? String,
               let value = myArgs["value"] as? String {
                
                updateKey(key: key, value: value)
                result(true)
            }else{
                result(false)
            }
            
            break;
        default:
            break;
        }
        
        
    }
    
    func removeKey(key: String)  {
        KKeychainPass.remove(service: "Auth", name: "keychainf" + key)
    }
    
    func writeKey(key: String,value: String)  {
        KKeychainPass.save(service: "Auth", name: "keychainf" + key, data: value)
    }
    
    func updateKey(key: String,value: String)  {
        KKeychainPass.update(service: "Auth", name: "keychainf" + key, data: value)
    }
    
    func readKey(key: String) -> String{
        let pass = KKeychainPass.load(service: "Auth" , name: "keychainf" + key)
        return pass ?? ""
    }
}
