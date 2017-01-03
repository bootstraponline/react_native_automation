package com.button.test;

import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;

import com.button.MainActivity;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;


import android.support.test.espresso.ViewInteraction;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withContentDescription;
import static android.support.test.espresso.matcher.ViewMatchers.withId;
import static android.support.test.espresso.matcher.ViewMatchers.withTagValue;
import static android.support.test.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.is;

@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    // TODO: The app is crashing on startup (react-native run android)
    // will be fixed in react-native 40. for now, must manually enable overdraw permission
    //
    // Settings -> Apps -> Advanced -> Draw over other app
    //
    // https://github.com/facebook/react-native/issues/3150
    // https://github.com/facebook/react-native/issues/10454
    // https://github.com/facebook/react-native/pull/11316
    // adb -s emulator-5554 shell am start -n com.button/.MainActivity)...
    // Starting: Intent { cmp=com.button/.MainActivity }
    @Rule
    public ActivityTestRule<MainActivity> mActivityTestRule = new ActivityTestRule<>(MainActivity.class);


    public void sleep(int amount) {
        try {
            Thread.sleep(amount);
        } catch (Exception e) {

        }
    }

    @Test
    public void activityRenders() {
        // Wait for screen to draw. We'll have to use an idle resource counter in the future.
        sleep(5000);

        onView(withContentDescription("automation_button_label")).check(matches(isDisplayed()));
        // view tag doesn't work on buttons
        // onView(withTagValue(is((Object) "automation_button_id"))).perform(click());

        // image can be found by label & id
        onView(withContentDescription("automation_image_label")).check(matches(isDisplayed()));
        onView(withTagValue(is((Object) "automation_image_id"))).check(matches(isDisplayed()));
    }
}
