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

    let autoImage = e.selectBy(label: "automation_image_label")
    autoImage.assert(grey_sufficientlyVisible());

    let autoImage2 = e.selectBy(id: "automation_image_id")
    autoImage2.assert(grey_sufficientlyVisible());
  }
}
