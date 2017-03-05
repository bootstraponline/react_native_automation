import XCTest
import EarlGrey

// MARK: Element selectors
class e {

  static func selectBy(id:String, file:StaticString = #file, line:UInt = #line) -> GREYElementInteraction {
    return EarlGrey.select(elementWithMatcher: grey_accessibilityID(id), file: file, line: line)
  }

  static func selectBy(label:String, file:StaticString = #file, line:UInt = #line) -> GREYElementInteraction {
    return EarlGrey.select(elementWithMatcher: grey_accessibilityLabel(label), file: file, line: line)
  }

  static func firstElement(_ matcher:GREYElementInteraction) -> GREYElementInteraction {
    return matcher.atIndex(0)
  }
}

// MARK: Global utils
func dump() {
  print(GREYElementHierarchy.hierarchyStringForAllUIWindows())
}

func grey_fromFile(_ file:StaticString, _ line:UInt) {
  EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
}

func waitFor(_ seconds:TimeInterval) {
  let timeout = Date(timeIntervalSinceNow: seconds)
  RunLoop.current.run(until: timeout)
}

let elementTimeout:TimeInterval = 30.0 // seconds

// MARK: Element actions
extension GREYElementInteraction {
  func tap(file:StaticString = #file, line:UInt = #line) {
    grey_fromFile(file, line)
    self.assertExists(file: file, line: line)

    // condition does not raise error on failure.
    let success = GREYCondition(name: "Tapping element", block: { _ in
      var errorOrNil: NSError?
      self.perform(grey_tap(), error: &errorOrNil)
      let success = errorOrNil == nil

      return success
    }).wait(withTimeout: elementTimeout)

    if (!success) { self.perform(grey_tap()) }
  }

  func assertExists(file:StaticString = #file, line:UInt = #line) {
    grey_fromFile(file, line)
    let success = GREYCondition(name: "Waiting for element to exist", block: { _ in
      var errorOrNil: NSError?
      self.assert(with: grey_notNil(), error: &errorOrNil)
      let success = errorOrNil == nil
      return success
    }).wait(withTimeout: elementTimeout)

    if (!success) { self.assert(with: grey_notNil()) }
  }
}
