# WhatTheSign
This application provides information about road signs of Russia.\
The app also uses machine learned to recognize signs from a photo.

<p align="center">
<img src="https://user-images.githubusercontent.com/82824022/215159649-8a7f5d22-5c1b-4ec1-8895-9cc00c4303c7.PNG" width=30% height=30%>
<img src="https://user-images.githubusercontent.com/82824022/215159640-8c1cc77c-bb0f-4211-978e-11a425888e3e.PNG" width=30% height=30%>
<img src="https://user-images.githubusercontent.com/82824022/215159608-43f7db5a-ad5c-4405-bf63-eb12b7aa0c9b.PNG" width=30% height=30%>

</p>
<p align="center">
<img src="https://user-images.githubusercontent.com/82824022/215159629-8db85f92-bba4-4187-8da2-db9a0964b909.PNG" width=30% height=30%>
<img src="https://user-images.githubusercontent.com/82824022/215164640-80f0d0c2-51c4-4083-a11d-e8b1c236b2b2.PNG" width=30% height=30%>
</p>

The main functionality that was applied in this project:
- UIImagePickerController
- VNCoreModel and VNCoreModelRequest
- UINavigationController
- UIAlertController
- UITableView Delegate and Datasource methods
- Camera Usage Description
- UITapGestureRecognizer to hide the keyboard

At some moment - the project was refactored to exclude a storyboard UI design.\
All UI is writen by code since then, but i saved my first project realisation into a separate branch, called ui_by_storyboard(before_refactoring).\
For self development, I used pre-saved data stored in plist table as datasource for the app.\
Unfortunately - the model is not trained enough and has difficulty recognizing photographs of signs (requires improvement).

Disclaimer:
The project was made for educational purposes only.
