import FluentSQLite
import Vapor

final class GameState: SQLiteModel  {
    
    var id: Int?
    
    // Game constants
    let maxAttempts: Int
    let minValue: Int
    let maxValue: Int
    
    // Game variables
    var numberToGuess: Int
    var remainingGuesses: Int
    
    // Constructor
    init(id: Int? = nil) {
        self.id = id
        maxAttempts = 10
        minValue = 1
        maxValue = 10
        numberToGuess = Int(arc4random_uniform(100) + 1)
        remainingGuesses = 10
    }
}

// Allows to be used as a dynamic migration
extension GameState: Migration {}

// Allows to be encoded and decoded from/to HTTP message
extension GameState: Content {}

// Allows to be used as dynamic parameter in route definitions
extension GameState: Parameter {}

