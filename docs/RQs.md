# OTP Bank – Frontend Task (Flutter)

Dear interviewer!

Welcome to the Stopwatch App Coding Assignment.

Your goal is to develop a stopwatch app using Flutter and Dart. The app should allow users to start, pause, and reset the stopwatch. Additionally, we have included some additional requirements to test your skills and measure your seniority level.

---

## Task 1

Create a stopwatch app that allows users to start, pause, and reset the stopwatch.

### Requirements

1. The app should have a start button, a pause button, and a reset button.
2. When the start button is pressed, the stopwatch should start counting up from 0.
3. Pressing the pause button should pause the stopwatch, and pressing it again should resume the stopwatch from where it left off.
4. Pressing the reset button should reset the stopwatch to 0.
5. The app should display the current elapsed time in minutes, seconds, and milliseconds.
6. The UI should be visually appealing and responsive.

### Test Cases

1. Create a unit test to verify that pressing the start button starts the stopwatch and the elapsed time increases over time.
2. Write a unit test to ensure that pressing the pause button pauses the stopwatch and the elapsed time stops increasing.
3. Implement a unit test to confirm that pressing the reset button resets the stopwatch to 0 and stops the elapsed time.
4. Write a widget test to simulate user interactions by tapping the buttons and verify that the UI responds correctly.
5. Include a test case to handle edge cases, such as verifying that pressing the start button multiple times without pausing or resetting doesn't cause unexpected behavior.

### Expected Output

- The stopwatch app should accurately count and display the elapsed time in real-time.
- The start, pause, and reset buttons should respond to user input correctly.
- The UI should be intuitive and user-friendly.

### Guidelines

- Use the Flutter framework and Dart programming language to build the app.
- Pay attention to code organization, readability, and best practices.
- Utilize appropriate Flutter widgets and concepts for the UI and app logic.
- Implement appropriate event handling for button presses and stopwatch functionality.

---

## Task 2

Implement lap functionality in the stopwatch app.

### Requirements

1. Add a lap button to the UI.
2. When the lap button is pressed, the current elapsed time should be recorded and displayed in a separate list or widget.
3. The list of recorded laps should update in real-time as new laps are added.
4. Include a clear button to reset the lap list.

### Test Cases

Test cases are not required for this task, but feel free to implement your own.

### Expected Output

- The lap functionality should allow users to record and display multiple laps during the stopwatch's operation.
- The recorded laps should update dynamically as new laps are added or cleared.
- The UI should be intuitive and visually appealing, clearly distinguishing between the main stopwatch and the lap list.

### Guidelines

- Modify the UI and app logic to incorporate the lap functionality.
- Ensure the lap list updates correctly as laps are recorded.
- Add appropriate event handling and button functionality for the lap and clear buttons.
- Consider the UI design and organization of the lap list to enhance usability.

---

## Nice-to-Have Task

Implement an analog clock that visually displays the elapsed time of the stopwatch.

### Requirements

1. Design and integrate an analog clock widget into the stopwatch app UI.
2. As the stopwatch runs, the clock's hour, minute, and second hands should move in sync with the elapsed time.
3. The clock should provide a visual representation of the current time based on the stopwatch’s elapsed time.
4. Consider customizing the clock design to enhance the app’s visual appeal.

### Test Cases

Test cases are not required for this task, but feel free to implement your own.

### Expected Output

- The analog clock should update and reflect the elapsed time accurately.
- The hour, minute, and second hands should move smoothly, representing the passage of time.
- The analog clock should provide a clear indication of the current time based on the stopwatch's elapsed time.

### Guidelines

- Research and utilize Flutter libraries or custom code to create an analog clock widget.
- Synchronize the clock's hands with the elapsed time of the stopwatch.
- Ensure smooth movement of the hands to provide a visually appealing user experience.
- Customize the clock’s design to match the overall aesthetic of the stopwatch app.

---

Good luck with the assignment! We're excited to see your implementation and assess your skills.