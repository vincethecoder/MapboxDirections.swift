import Foundation

#if os(OSX)
    import Cocoa
#elseif os(watchOS)
    import WatchKit
#else
    import UIKit
#endif

/**
 :nodoc:
 A component of a `VisualInstruction` that represents a single run of similarly formatted text or an image with a textual fallback representation.
 */
@objc(MBVisualInstructionComponent)
open class VisualInstructionComponent: NSObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case text
        case imageURL
    }
    
    /**
     :nodoc:
     The plain text representation of this component.
     
     Use this property if `imageURLs` is an empty dictionary or if the URLs contained in that property are not yet available.
     */
    @objc public let text: String?
    
    /**
     :nodoc:
    The URL to an image representation of this component.
 
    The URL refers to an image that uses the device’s native screen scale.
    */
    @objc public var imageURL: URL?
    
    
    /**
     :nodoc:
     The type of visual instruction component. You can display the component differently depending on its type.
     */
    @objc public var type: VisualInstructionComponentType
    
    /**
     :nodoc:
     Initialize A `VisualInstructionComponent`.
     */
    // TODO: Fix
//    @objc public convenience init(json: [String: Any]) {
//        let text = json["text"] as? String
//
        if let _ = json["delimiter"] as? Bool {
            type = .delimiter
        } else {
            type = .destination
        }
        
//        var imageURL: URL?
//
//        if let baseURL = json["imageBaseURL"] as? String {
//            let scale: CGFloat
//            #if os(OSX)
//                scale = NSScreen.main?.backingScaleFactor ?? 1
//            #elseif os(watchOS)
//                scale = WKInterfaceDevice.current().screenScale
//            #else
//                scale = UIScreen.main.scale
//            #endif
//            imageURL = URL(string: "\(baseURL)@\(Int(scale))x.png")
//        }
//
//        self.init(text: text, imageURL: imageURL)
//    }
    
    /**
     :nodoc:
     Initialize A `VisualInstructionComponent`.
     */
    @objc public init(type: VisualInstructionComponentType, text: String?, imageURL: URL?) {
        self.text = text
        self.imageURL = imageURL
    }
}