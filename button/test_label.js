function testLabel(description) {
  return {
                    testID: description + "_id",
        accessibilityLabel: description + "_label"
  }
}

export default testLabel
