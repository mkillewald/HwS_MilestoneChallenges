# HwS_MilestoneChallenges

My solutions to the eleven milestone challenges from the companion guide book for "Hacking With Swift" by Paul Hudson 

### Milestone 1: Fizz Buzz

• Write a function that accepts an integer as input and returns a string.  
• If the integer is evenly divisible by 3 the function should return the string “Fizz”.  
• If the integer is evenly divisible by 5 the function should return “Buzz”.  
• If the integer is evenly divisible by 3 and 5 the function should return “Fizz Buzz”.  
• For all other numbers the function should just return the input number.  

### Milestone 2: World Flags

Create an app that lists various world flags in a table view. When one of them is tapped, 
slide in a detail view controller that contains an image view, showing the same flag full size.
On the detail view controller, add an action button that lets the user share the flag picture 
and country name using UIActivityViewController.

### Milestone 3: Groccery List

Create an app that lets people create a shopping list by adding items to a table view

### Milestone 4: Hangman Game

Make a hangman game using UIKit. As a reminder, this means choosing a random word from a list of 
possibilities, but presenting it to the user as a series of underscores. So, if your word was 
“RHYTHM” the user would see “??????”. The user can then guess letters one at a time: if they guess 
a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect 
letter, they inch closer to death. If they give seven incorrect answers they lose, but if they manage to 
spell the full word before that they win.

### Milestone 5: Storm Viewer with UICollectionView

Re-make project 1, Storm Viewer, using a UICollectionViewController as seen in project 10

### Milestone 6: Country Facts

Make an app that contains facts about countries: show a list of country names in a table view, 
then when one is tapped bring in a new screen that contains its capital city, size, population, 
currency, and any other facts that interest you. The type of facts you include is down to you.

### Milestone 7: Notes clone

Recreate the iOS Notes app. I suggest you follow the iPhone version, because it’s fairly simple: a navigation controller, a table view controller, and a detail view controller with a full-screen text view.

### Milestone 8: Shooting Gallery

Make a shooting gallery game using SpriteKit: create three rows on the screen, then have targets slide across from one side to the other. If the user taps a target, make it fade out and award them points.

### Milestone 9: Swift Extensions

Implement five Swift language extensions 

1. Extend the Integer protocol with an isEven() method that returns true if a number is even and false if it’s odd.  
2. Extend String with a length property that returns the number of characters it has.  
3. Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over a specified number of seconds.  
4. Extend Array so that it has a mutating shuffle() method that wraps the arrayByShufflingObjects(in:) method from GameplayKit more neatly. You should use the typecast as! Array to have Swift automatically substitute the actual array type.  
5. Extend Array so that it has a mutating remove(item:) method. Tip: you will need to add the Comparable constraint to make this work!  

### Milestone 10: Rainbow

Extend the Core Graphics drawing sandbox from project 26 to add a new method: drawRainbow(). Yes, that should do pretty much what you might imagine: you’ll need to draw concentric rings of colors centered on the bottom of the image so that users see rainbow-like arcs.

### Milestone 11: Private Photos

Create a private photos app – think Mission Impossible, or at least as close as you can get to it in a programming tutorial! The Notes app for iOS has the ability to lock certain notes so that Touch ID must be used to reveal the note, and your mission is to create something similar for a photo library.
