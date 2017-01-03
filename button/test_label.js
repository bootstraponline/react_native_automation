function testLabel(description) {
  // Term               | iOS                | Android
  // accessibilityLabel | accessibilityLabel | content description
  // testID             | accessibilityID    | view tag
  return {
                accessible: true,
                    testID: description + "_id",
        accessibilityLabel: description + "_label"
  }
}

export default testLabel
