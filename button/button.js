import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  Button,
  Image,
  View
} from 'react-native';

import testLabel from './test_label.js'

export default class button extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          onPress={()=>{}}
          title="automation"
          {...testLabel('automation_button')}
        />

        <Image source={require('./img/image.png')}
        {...testLabel('automation_image')} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});

/*

EarlGrey iOS UI hierarchy

<Button> is:
<RCTView:0x7f99f1013fc0; AX=Y; AX.label='automation_button_label'; AX.frame={{153.66666666666666, 333.33333333333331}, {106.99999999999997, 37.666666666666686}}; AX.activationPoint={207.16666666666663, 352.16666666666663}; AX.traits='UIAccessibilityTraitButton'; AX.focused='N'; frame={{153.66666666666666, 333.33333333333331}, {107, 37.666666666666664}}; opaque; alpha=1>

<Image> is:
<RCTImageView:0x7f99f1014710; AX=N; AX.id='automation_image_id'; AX.label='automation_image_label'; AX.frame={{133, 371}, {148, 136}}; AX.activationPoint={207, 439}; AX.traits='UIAccessibilityTraitImage'; AX.focused='N'; frame={{133, 371}, {148, 136}}; alpha=1>

*/