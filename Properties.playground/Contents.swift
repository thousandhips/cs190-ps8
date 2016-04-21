/*:
 # CS 190 Problem Set #8&mdash;Computed Properties
 
 [Course Home Page]( http://physics.stmarys-ca.edu/classes/CS190_S16/index.html )
 
 Due: Tuesday, April 26th, 2016.
 
 ## Reading that is Related to this Week's Lectures and/or This Problem Set
 
 Apple's [Swift Programming Language book]( https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11 ) has a chapter devoted to properties. That would be very good to read. Also, the [ToDo tutorial]( https://github.com/brianhill/tutsplus-todo-app-3 ) we did in class would be very good to work through again because going through it once fast with me is probably not enough to make it stick.
 
 ## Directions Specific to this Problem Set
 
 According to Apple's doc on the [types in the CoreLocation framework]( https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CoreLocationDataTypesRef ), latitudes and longitudes are stored in floating point doubles that are in degrees and computes distances in floating point doubles that are in meters.
 
 Part 1 (2 pts): Estimate the distance of from San Francisco to Moraga in meters. Get the latitude/longitude of San Francisco, Oakland and Moraga, and create a GPS Track that goes from San Francisco to Oakland to Moraga. Write a unit test that tests that the length of this GPS track is approximately correct.
 
 HINT: by approximately correct, it's good enough to imagine that you could go straight between these locations. If you look at Google maps, the total distance appears to be more than 15 kilometers but less than 30 kilometers. If your unit test tests both those facts, that is good enough.
 
 Part 2 (3 pts): All three unit tests (the two that I wrote and the one that you wrote in part 1) will now fail, because the computed property that I wrote always returns 1000 meters. Your job for Part 2 is to write a correct implementation for the computed property.
 
HINT: Apple has done most of the hard work for you in the class CLLocation. See Apple's doc on this class in the [CoreLocation framework doc]( https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CoreLocation_Framework/index.html ).
 
 ## General Directions for all Problem Sets
 
 1. Fork this repository to create a repository in your own Github account. Then clone your fork to whatever machine you are working on.
 
 2. These problem sets are created with the latest version of Xcode and Mac OS X: Xcode 7.3 and OS X 10.11.4. I haven't tested how well this problem set will work under Xcode 7.2.1. Please go into Galileo 205, 206 or 208 and test your work rather than relying on the Xcode 7.2.1 machines in Garaventa.
 
 3. Under no circumstances copy-and-paste any part of a solution from another student in the class. Also, under no circumstances ask outsiders on Stack Exchange or other programmers' forums to help you create your solution. It is however fine&mdash;especially when you are truly stuck&mdash;to ask others to help you with your solution, provided you do all of the typing. They should only be looking over your shoulder and commenting. It is of course also fine to peruse StackExchange and whatever other resources you find helfpul.
 
 4. Your solution should be clean and exhibit good style. At minimum, Xcode should not flag warnings of any kind. Your style should match Apple's as shown by their examples and declarations. Use the same indentation and spacing around operators as Apple uses. Use their capitalization conventions. Use parts of speech and grammatical number the same way as Apple does. Use descriptive names for variables. Avoid acronyms or abbreviations. I am still coming up to speed on good Swift style. When there appears to be conflict my style and Apple's, copy Apple's, not mine.
 
 5. When completed, before the class the problem set is due, commit your changes to your fork of the repository. I should be able to simply clone your fork, build it and execute it in my environment without encountering any warnings, adding any dependencies or making any modifications.
 
 ## Unit tests that Run Automatically */

import CoreLocation

struct LocationTrack {
    
    var locations: [CLLocation]
    
    var length: CLLocationDistance {
        // this function should sum up all the distances between the locations in the track
        return 1000.0 // right now it just returns 1000 (in meters, which is one kilometer).
    }
    
}


import XCTest

class LocationTrackTestSuite: XCTestCase {

    func testLengthOfTrackWithNoPoints() {
        let noPointsTrack = LocationTrack(locations: [])
        let expectedResult: CLLocationDistance = 0
        XCTAssertEqual(expectedResult, noPointsTrack.length, "Zero point track should have zero length.")
    }
    
    func testLengthOfTrackWithOnePoint() {
        let oakland = CLLocation(latitude: 37.8044, longitude: 122.2711)
        let onePointTrack = LocationTrack(locations: [oakland])
        let expectedResult: CLLocationDistance = 0
        XCTAssertEqual(expectedResult, onePointTrack.length, "Single point track should have zero length.")
    }
    
    
}
/*:
 The last bit of arcana is necessary to support the execution of unit tests in a playground, but isn't documented in [Apple's XCTest Library]( https://github.com/apple/swift-corelibs-xctest ). I gratefully acknowledge Stuart Sharpe for sharing it in his blog post, [TDD in Swift Playgrounds]( http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/ ). */
class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

LocationTrackTestSuite.defaultTestSuite().runTest()

