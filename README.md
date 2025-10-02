# Dual-N-Back Brain Training Game

This is an iOS application for playing the Dual-N-Back brain training game. The project is structured to be easily extensible, allowing for the addition of other brain training games in the future.

## How to Build and Run

To build and run this application, you will need Xcode.

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Open the project in Xcode:**
    Navigate to the project directory and open the `.xcodeproj` or `.xcworkspace` file.
    *(Note: As this is a scaffold, a project file is not yet generated. You can create a new Xcode project and add these files to it.)*
3.  **Select a target:**
    Choose an iOS simulator or a connected physical device from the target menu in Xcode.
4.  **Run the app:**
    Click the "Run" button (the play icon) or press `Cmd+R`.

## Project Structure

The project is organized into a modular structure to promote extensibility and maintainability.

-   `DualNBackApp.swift`: The main entry point for the SwiftUI application.
-   `ContentView.swift`: The main view of the app, intended to be a launcher for different games.
-   `Core/`: This directory contains the shared components and protocols that form the foundation for all games within the app.
    -   `Models/Game.swift`: A protocol defining the basic properties of a game.
    -   `ViewModels/GameViewModel.swift`: A protocol for game logic and state management.
    -   `Views/GameView.swift`: A protocol for SwiftUI views that represent a game.
-   `Games/`: This directory holds the specific implementations of each brain training game.
    -   `DualNBack/`: Contains all the files related to the Dual-N-Back game.
        -   `Models/`: Data structures for the game state, stimuli, and settings.
        -   `ViewModels/`: The view model that contains the game's logic.
        -   `Views/`: The SwiftUI views for the game's UI.

## How to Add a New Game

The protocol-oriented structure makes it straightforward to add new games.

1.  **Create a new game directory:**
    Add a new subdirectory under `Games/` for your new game (e.g., `Games/MemoryMatrix/`).
2.  **Implement the core protocols:**
    -   Create a new model for your game that conforms to the `Game` protocol.
    -   Create a view model that conforms to `GameViewModel`.
    -   Create a SwiftUI view that conforms to `GameView`.
3.  **Update the game launcher:**
    Modify `ContentView.swift` to include an option to launch your new game. This could be a navigation link in a list of available games.