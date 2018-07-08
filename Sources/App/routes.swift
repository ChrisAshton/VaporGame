import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)

    // Game routes
    let controller = GameController()
    router.get("guessing-game", use: controller.newGame)
    router.get("host", use: controller.renderHost)
    
    // Sesssions Router
    let sessions = router.grouped("sessions").grouped(SessionsMiddleware.self)
    
    sessions.get("get") { req -> String in
        // access "name" from session or return n/a
        return try req.session().data["session-entity-id"] ?? "n/a"
    }
    
    sessions.get("set/name", String.parameter) { req -> String in
        // get router parameter
        let name = try req.parameters.next(String.self)
        
        // set the name to session at key "name"
        try req.session()["name"] = name
        
        // return newly set name
        return name
    }

}
