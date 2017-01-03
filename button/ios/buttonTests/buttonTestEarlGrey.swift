import EarlGrey
import XCTest

class EarlGreyExampleSwiftTests: XCTestCase {

  func testButton() {
    EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("automation_button_label")).assert(grey_sufficientlyVisible());
  }

  func testImage() {
    // grey_accessibilityLabel does not match on AX.N to be
    // consistent with accessibility inspector / voice over.
    //
    // react-native must set accessibility: true on elements to match on them by label
    // https://facebook.github.io/react-native/docs/accessibility.html
    EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("automation_image_label")).assert(grey_sufficientlyVisible());

    EarlGrey.select(elementWithMatcher: grey_accessibilityID("automation_image_id")).assert(grey_sufficientlyVisible());
  }
}
