# Secure Notes
 
## Overview
This is the code test for Secure Notes as given by Collabera. The app uses Biometrics to authenticate a user for access to notes stored locally using core data using Combine, SwiftUI, and MVVM-C architecture.


## Requirements:
- Implement biometric authentication (TouchID/FaceID) to secure access to the app.
- Create, read, update & delete (CRUD) notes. Each note contains a title and content.
- Use CoreData to persist notes locally.
- Utilize Combine for handling asynchronous events and data binding.
- Build the user interface using SwiftUI.
- Use MVVM-C (Model-View-ViewModel-Coordinator) architecture.
- Add unit test cases. 
 
## Description

The project is structured using the MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern, emphasizing modularity and replaceability through protocols, aligning with the principles of the ONION architecture. The key components and their functionalities are outlined below:

## Modular Design:

### CoreData
The CoreData functionality is encapsulated within a module behind the StorageService protocol. This abstraction allows for the seamless replacement of CoreData with other persistence technologies (e.g., SQLite) without impacting other parts of the application.
CoreData operations, such as CRUD (Create, Read, Update, Delete), are implemented in a service conforming to StorageService.
Modules:

### Data Module
Contains the core data logic, including the implementation of StorageService with CoreData.
Security Module:
Manages authentication and security features like FaceID.
### Domain Module:
    Defines the core data models and protocols shared across other modules.
### Utility Module:
    Provides common utility functions and extensions used throughout the application.
### MVVM-C Architecture:
#### Model:
    Data models and business logic.
#### View:
    SwiftUI views that represent the user interface.
#### ViewModel:
    Manages the state and business logic for each view. It interacts with the DataService, which provides CRUD operations.
    Uses Combine for data binding and asynchronous operations.
#### Coordinator:
    Manages the navigation flow of the application, ensuring a clear separation of navigation logic from views and view models.
    Combine Framework:

    Utilized as the main technology for reactive programming and data flow within the application.
    CoreData operations and state changes are propagated using Combine publishers.
### FaceID:

    Implemented within the Security module to enhance user authentication and security.

### Testing:
Unit tests are written for business logic and view model operations to ensure the correctness of CRUD operations and data flow.
Tests ensure that the view models interact correctly with the data services and handle data operations as expected.

I added a new test suit to test all the modules and their code with one test run.
