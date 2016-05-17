# CSC 545 Term Project

## Overview
This steganography application is designed to hide and find secret messages within an image. It can be used with a GUI interface.

The first version was finished on 5/12/2016, and is partially hosted in this repository.

## Setup Instructions
To try out our steganography algorithms:

 1. Install [Processing](https://www.processing.org/).
 2. Fork our repository.
 3. Double-click `encryptionMain.pde` to open it with Processing's built-in editor.
 4. Click the *Run* button.

`encryptionMain.pde` runs the other Processing functions from its `setup()` and `draw()` functions. To change which image it shown, use the number keys 0-5 as documented in the code.

## Features

### Steganography Functions
Four stenography functions are used for either combining the user's message with an image, or extracting an already hidden message from the image.

 * Text -> Image_Holding_Text
 * Image -> Image_Holding_Image
 * Image_Holding_Text -> Text
 * Image_Holding_Image -> Image

The first two functions also require a containing image to be provided. The containing image will be used to store the text or image being hidden.

### Essential GUI Components
The GUI allows the user to hide and find messages which use this program's method of steganography. The GUI also uses all four functions defined in the *Steganography Functions* section above. It also allows the user to choose which image to place a message into or extract a message from. Five components of the GUI include the following.

 * Buttons
 * Display Box
 * Image Upload Dialogue Box
 * Steganography Algorithms
 * Text Input

## Tools

### Git and GitHub
 * [Git GUI Client - SourceTree](https://www.atlassian.com/software/sourcetree/overview/)
 * [Fundamentals of Forking](https://guides.github.com/activities/forking/)
 * [Forking a Repository](https://help.github.com/articles/fork-a-repo/)

### Languages
 * Java
 * [Processing - Official Website](https://www.processing.org/)

## Initial Contributors
The first five contributors to this application are @bro-dell, @lae1425, @NBumgardner, @SeanStraus21, and @sgabbard. They finished the first version of this project by 5/12/2016, and it is partially hosted on this repository. 
