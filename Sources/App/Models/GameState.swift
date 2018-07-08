import FluentSQLite
import Vapor

final class GameState: SQLiteModel  {
    
    var id: Int?
    
    // Game constants
    let maxAttemps: UInt8?
    let minValue: UInt8?
    let maxValue: UInt8?
    
    // Game variables
    private var numberToGuess: UInt8?
    var remainingGuesses: UInt8?
    
    // Constructor
    init(id: Int? = nil) {
        self.id = id
        maxAttemps = 10
        minValue = 1
        maxValue = 100
        numberToGuess = UInt8(arc4random_uniform(100) + 1)
        remainingGuesses = 10
    }
}

// Allows to be used as a dynamic migration
extension GameState: Migration {}

// Allows to be encoded and decoded from/to HTTP message
extension GameState: Content {}

// Allows to be used as dynamic parameter in route definitions
extension GameState: Parameter {}
