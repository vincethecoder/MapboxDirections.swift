import XCTest
@testable import MapboxDirections

class RouteOptionsTests: XCTestCase {
    
    
    func testCoding() {
        let options = RouteOptions.testInstance
        let encoder = JSONEncoder()
        let data = try! encoder.encode(options)
        NSKeyedArchiver.archiveRootObject(data, toFile: "options")
        
        let unarchivedData = NSKeyedUnarchiver.unarchiveObject(withFile: "options") as! Data
        let unarchivedOptions = try! JSONDecoder().decode(RouteOptions.self, from: unarchivedData)
        
        XCTAssertNotNil(unarchivedOptions)
        
        let coordinates = RouteOptions.testCoordinates
        let unarchivedWaypoints = unarchivedOptions.waypoints
        XCTAssertEqual(unarchivedWaypoints.count, coordinates.count)
        XCTAssertEqual(unarchivedWaypoints[0].coordinate.latitude, coordinates[0].latitude)
        XCTAssertEqual(unarchivedWaypoints[0].coordinate.longitude, coordinates[0].longitude)
        XCTAssertEqual(unarchivedWaypoints[1].coordinate.latitude, coordinates[1].latitude)
        XCTAssertEqual(unarchivedWaypoints[1].coordinate.longitude, coordinates[1].longitude)
        XCTAssertEqual(unarchivedWaypoints[2].coordinate.latitude, coordinates[2].latitude)
        XCTAssertEqual(unarchivedWaypoints[2].coordinate.longitude, coordinates[2].longitude)
        
        XCTAssertEqual(unarchivedOptions.profileIdentifier, options.profileIdentifier)
        XCTAssertEqual(unarchivedOptions.locale, options.locale)
        XCTAssertEqual(unarchivedOptions.includesSpokenInstructions, options.includesSpokenInstructions)
        XCTAssertEqual(unarchivedOptions.distanceMeasurementSystem, options.distanceMeasurementSystem)
        XCTAssertEqual(unarchivedOptions.includesVisualInstructions, options.includesVisualInstructions)
        XCTAssertEqual(unarchivedOptions.roadClassesToAvoid, options.roadClassesToAvoid)
    }
    func testCopying() {
        let testInstance = RouteOptions.testInstance
        guard let copy = testInstance.copy() as? RouteOptions else { return XCTFail("RouteOptions copy method should an object of same type") }
        XCTAssertNotNil(copy, "Copy should not be nil.")
        XCTAssertTrue(testInstance == copy, "Test Instance and copy should be semantically equivalent.")
        XCTAssertFalse(testInstance === copy, "Test Instance and copy should not be identical.")
        
    }
    
    //MARK: API Name Handling Tests
    private static var testWaypoints: [Waypoint] { return [Waypoint(coordinate: CLLocationCoordinate2D(latitude: 39.27664, longitude:-84.41139)),
                                                        Waypoint(coordinate: CLLocationCoordinate2D(latitude: 39.27277, longitude:-84.41226))]}


    // TODO: Fix
//    private func response(for fixtureName: String, waypoints: [Waypoint] = testWaypoints) -> (waypoints:[Waypoint], route:Route)? {
//        let testBundle = Bundle(for: type(of: self))
//        guard let fixtureURL = testBundle.url(forResource:fixtureName, withExtension:"json") else { XCTFail(); return nil }
//        guard let fixtureData = try? Data(contentsOf: fixtureURL, options:.mappedIfSafe) else {XCTFail(); return nil }
//        guard let fixtureOpaque = try? JSONSerialization.jsonObject(with: fixtureData), let fixture = fixtureOpaque as? JSONDictionary  else { XCTFail(); return nil }
//
//        let subject = RouteOptions(waypoints: waypoints)
//        let response = subject.response(from: fixture)
//
//        guard let waypoints = response.0, let routes = response.1 else { XCTFail("Expected responses not returned from service"); return nil}
//        guard let primary = routes.first else {XCTFail("Expected a route in response"); return nil}
//        return (waypoints:waypoints, route:primary)
//    }

    // TODO: Fix
//    func testResponseWithoutDestinationName() {
//        let response = self.response(for: "noDestinationName")!
//        XCTAssert(response.route.legs.last!.destination.name == nil, "API waypoint with no name (aka \"\") needs to be represented as `nil`.")
//    }

    // TODO: Fix
//    func testResponseWithDestinationName() {
//        let response = self.response(for: "apiDestinationName")!
//        XCTAssert(response.route.legs.last!.destination.name == "testpass", "Waypoint name in fixture response not parsed correctly.")
//    }

    // TODO: Fix
//    func testResponseWithManuallySetDestinationName() {
//        let manuallySet = RouteOptionsTests.testWaypoints
//        manuallySet.last!.name = "manuallyset"
//
//        let response = self.response(for: "apiDestinationName", waypoints: manuallySet)!
//        XCTAssert(response.route.legs.last!.destination.name == "manuallyset", "Waypoint with manually set name should override any computed name.")
//    }
}

private extension RouteOptions {
    static var testCoordinates: [CLLocationCoordinate2D] {
        return [
            CLLocationCoordinate2D(latitude: 52.5109, longitude: 13.4301),
            CLLocationCoordinate2D(latitude: 52.5080, longitude: 13.4265),
            CLLocationCoordinate2D(latitude: 52.5021, longitude: 13.4316),
        ]
    }
    static var testInstance: RouteOptions {
        let opts = RouteOptions(coordinates: self.testCoordinates, profileIdentifier: .automobileAvoidingTraffic)
        opts.locale = Locale(identifier: "en_US")
        opts.allowsUTurnAtWaypoint = true
        opts.shapeFormat = .polyline
        opts.routeShapeResolution = .full
        opts.attributeOptions = [.congestionLevel]
        opts.includesExitRoundaboutManeuver = true
        opts.includesSpokenInstructions = true
        opts.distanceMeasurementSystem = .metric
        opts.includesVisualInstructions = true
        opts.roadClassesToAvoid = .toll
        
        return opts
    }
}
