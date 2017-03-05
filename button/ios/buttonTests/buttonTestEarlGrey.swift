import EarlGrey
import XCTest

class EarlGreyExampleSwiftTests: XCTestCase {

  // calling .assert will bypass the waiting matcher.
  // instead assertExists is used.
  func testButton() {
    e.selectBy(label: "automation_button_label").assertExists()
  }

  func testImage() {
    // grey_accessibilityLabel does not match on AX.N to be
    // consistent with accessibility inspector / voice over.
    //
    // react-native must set accessibility: true on elements to match on them by label
    // https://facebook.github.io/react-native/docs/accessibility.html

    let autoImage = e.selectBy(label: "automation_image_label")
    autoImage.assertExists();

    let autoImage2 = e.selectBy(id: "automation_image_id")
    autoImage2.assertExists();
  }

  func testExpectedFailure() {
    let autoImage = e.selectBy(label: "does_not_exist")
    autoImage.assertExists();
  }
}
