import EarlGrey
import XCTest

class EarlGreyExampleSwiftTests: XCTestCase {

  func testBasicSelection() {
    EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("automation_button_label")).assert(grey_sufficientlyVisible());
  }
}
