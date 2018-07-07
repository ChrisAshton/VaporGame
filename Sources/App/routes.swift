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
    router.get("guessinggame", use: controller.renderHost)
    router.get("login") { req -> Future<View> in
        return try req.view().render("login")
    }
        
}
