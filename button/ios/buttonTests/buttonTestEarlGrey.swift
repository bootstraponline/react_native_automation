import EarlGrey
import XCTest

class EarlGreyExampleSwiftTests: XCTestCase {

  func testButton() {
    EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("automation_button_label")).assert(grey_sufficientlyVisible());
  }

  func testImage() {
    /*
     Why is this failing?
     
     [buttonTests.EarlGreyExampleSwiftTests testImage] : Assertion 'assertWithMatcher: matcherForSufficientlyVisible(>=0.750000)' was not performed because no UI element matching ((respondsToSelector(isAccessibilityElement) && isAccessibilityElement) && accessibilityLabel("automation_image_label")) was found.


     <RCTImageView:0x7fd30a9020d0; AX=N; AX.id='automation_image_id'; AX.label='automation_image_label'; AX.frame={{133, 319}, {148, 136}}; AX.activationPoint={207, 387}; AX.traits='UIAccessibilityTraitImage'; AX.focused='N'; frame={{133, 319}, {148, 136}}; alpha=1>
    */
    EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("automation_image_label")).assert(grey_sufficientlyVisible());

    EarlGrey.select(elementWithMatcher: grey_accessibilityID("automation_image_id")).assert(grey_sufficientlyVisible());
  }
}
