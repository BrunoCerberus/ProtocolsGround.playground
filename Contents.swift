//: Playground - noun: a place where people can play

import UIKit

protocol someProtocol {
    func sum(first: Int, second: Int)
}

protocol secondProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}

class ruller {
    class func divide(first: Int, second: Int){
    }
}

protocol fullyNamed {
    var fullName: String {get}
}

struct Pessoa: fullyNamed {
    var fullName: String
}

/// super class aways comes first
class firstClass: someProtocol, secondProtocol {
    func sum(first: Int, second: Int) {
        
    }
    var mustBeSettable: Int = 1
    var doesNotNeedToBeSettable: Int = 0
    
    let john = Pessoa(fullName: "John")
}

protocol MethodRequirements {
    func someMethod()
    func someMethodWithReturnType() -> String
    static func someStaticMethod(variadicParam:String...)
}

struct SomeStruct: MethodRequirements {
    func someMethod() {
        print("SomeMethod called")
    }
    
    func someMethodWithReturnType() -> String {
        print("someMethodWithReturnType called")
        return "return something"
    }
    
    static func someStaticMethod(variadicParam: String...) {
        print(variadicParam)
    }
}

let structObj = SomeStruct()
structObj.someMethod()
structObj.someMethodWithReturnType()
SomeStruct.someStaticMethod(variadicParam: "1","2","3")

//PROTOCOL WITH MUTATING METHOD
struct Rectangle {
    var width = 1
    var height = 1
    
    func area() -> Int {
        return width * height //doesnt modify anything
    }
    
    mutating func scaleBy(value: Int) {
        width *= value
        height *= value //modifies values
    }
    
//    func scaleByNotMutating(value: Int) {
//        width *= value
//        height *= value
//    }
}

var rectangle = Rectangle(width: 2, height: 2)
rectangle.width
rectangle.height
rectangle.area()
rectangle.scaleBy(value: 5)
rectangle.height
rectangle.width
//This is a explicit an error, because to a struct change it value the method that do the changes must be mutable
//rectangle.scaleByNotMutating(value: 4)

//PROTOCOLS WITH MUTATING METHODS
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

class ToogleClass: Togglable {
    var someBool = false
    func toggle() {
        someBool = true
    }
}

let toggleClassObj = ToogleClass()
toggleClassObj.toggle()
print("somebool is = \(toggleClassObj.someBool)")

//INITIALIZER REQUIREMENTS

protocol InitRequire {
    init(someParameter: Int)
}

class SomeClass: InitRequire {
    required init(someParameter: Int) {
        // Initializer 
    }
}

//DELEGATION
protocol CallBackDelegate {
    func somethingHappened()
}

class Class1 {
    var delegate: CallBackDelegate?
    func doSomething() {
        delegate?.somethingHappened()
    }
}

class Class2: CallBackDelegate {
    func somethingHappened() {
        print("something happened call back called")
    }
}

let class1 = Class1()
let class2 = Class2()
class1.delegate = class2
class1.doSomething()

//PROTOCOL WITH EXTENSION
protocol Growable {
    var age: Int? {get}
}

class Human {
    var name: String?
    var weight: Float?
}

extension Human: Growable {
    var age: Int? {
        return 20
    }
}
let humanObj = Human()
humanObj.age
humanObj.name

//we can do in inverse

class Animal {
    var age: Int? {
        return 10
    }
}

extension Animal: Growable {} // this works just fine

let animalObj = Animal()

//COLECTIONS OF PROTOCOLS

//Since animal and human objects confirms to the growable protocol, they can be stored in an array of type Growable
let growableArray:[Growable] = [humanObj, animalObj]
growableArray.first?.age

//PROTOCOL INHERITENCE
protocol InheritingProtocol: someProtocol, secondProtocol {
    
    var bacon: Int? {get}
}

class anotherObj: InheritingProtocol {
    var bacon: Int?
    var doesNotNeedToBeSettable: Int = 0
    var mustBeSettable: Int = 2
    func sum(first: Int, second: Int) {
        
    }
}

//PROTOCOL COMPOSITION

func printAgeOfAnimal(animal: Animal & Growable) {
    print(animal.age!)
}

printAgeOfAnimal(animal: animalObj) // prints 10

//PROTOCOL EXTENSIONS
protocol Rotating {
    var rotates:Bool {get}
}

extension Rotating {
    var rotates: Bool{
        return true
    }
}

class Fan: Rotating {}

let fanObj = Fan()
fanObj.rotates

//PROVIDING DEFAULT IMPLEMENTATION USING PROTOCOL EXTENSION
protocol Rotating2 {
    var rotating:Bool {get}
}

extension Rotating2 {
    var rotating: Bool {
        return true
    }
}

class Fan2: Rotating2 {
    var rotating: Bool {
        return false
    }
}
let fan2Obj = Fan2()
fan2Obj.rotating

//ADDING CONSTRAINTS TO PROTOCOL EXTENSIONS
extension Array where Element: Equatable {
    static func ==(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        return lhs == rhs
    }
}
