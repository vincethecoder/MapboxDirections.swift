import Foundation

/**
 A lane on the road approaching an intersection.
 */
@objc(MBLane)
public class Lane: NSObject, Codable {
    /**
     The lane indications specifying the maneuvers that may be executed from the lane.
     */
    @objc public let indications: LaneIndication
    
    let isValid: Bool
    
    internal init(indications: LaneIndication, valid: Bool = false) {
        self.indications = indications
        self.isValid = valid
    }
    
    private enum CodingKeys: String, CodingKey {
        case indications
        case valid
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(indications, forKey: .indications)
        try container.encode(isValid, forKey: .valid)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let descriptions = try container.decode([String].self, forKey: .indications)
        indications = LaneIndication(descriptions: descriptions)!
        isValid = try container.decode(Bool.self, forKey: .valid)
    }
}
