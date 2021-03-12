//
//  main.swift
//  lesson3
//
//  Created by Андрей Калюжный on 12.03.2021.
//

import Foundation

var modelCar: String//

enum EngineConditions: String{
    case switchedOn = "Двигатель запущен", SwitchedOff = "Двигатель выключен"
}

enum WindowsConditions: String {
    case open = "Окна открыты", close = "Окна закрыты"
}

enum OperationsLoadTrunk: String {
    case loadIntoTheTrunk = "Происходит загрузка в кузов", unloadIntoTheTrunk = "Происходит выгрузка из кузова", restingState
}

enum OperationsLoadBack: String {
    case loadIntoTheBack = "Происходит загрузка в багажник", unloadIntoTheBack = "Происходит выгрузка из багажника", restingState
}

struct Car {
    private let model: String
    private let yearsOfIssue: UInt16
    private let bodyVolume: UInt16
    private let trunkVolume: UInt16
    private var engineStarted: EngineConditions = EngineConditions.SwitchedOff
    private var windowsAreOpen: WindowsConditions{
        willSet{
            switch newValue {
            case .open:
                print("Происходит открытие окон у \(model)")
            case .close:
                print("Происходит закрытие окон у \(model)")
            }
        }
        
        didSet{
            print("\(windowsAreOpen.rawValue) у модели \(model)")
        }
    }
    private var loadTheCargoIntoTheTrunk: OperationsLoadTrunk{
        didSet{
            if loadTheCargoIntoTheTrunk != .restingState {
                let message: String
                
                switch loadTheCargoIntoTheTrunk {
                case .loadIntoTheTrunk:
                    message = "Загрузка в кузов \(model) завершена"
                case .unloadIntoTheTrunk:
                    message = "Выгрузка из кузова \(model) завершена"
                case .restingState:
                    message = ""
                }
                loadTheCargoIntoTheTrunk = .restingState
                
                print(message)
            }
        }
        willSet{
            if newValue != .restingState {
                print("\(newValue.rawValue) в модель \(model)")
            }
        }
    }
    private var loadTheCargoIntoTheBack: OperationsLoadBack{
        didSet{
            if loadTheCargoIntoTheBack != .restingState {
                let message: String
                
                switch loadTheCargoIntoTheBack {
                case .loadIntoTheBack:
                    message = "Загрузка в багажник \(model) завершена"
                case .unloadIntoTheBack:
                    message = "Выгрузка из багажника \(model) завершена"
                case .restingState:
                    message = ""
                }
                loadTheCargoIntoTheTrunk = .restingState
                
                print(message)
            }
        }
        willSet{
            if newValue != .restingState {
                print("\(newValue.rawValue) в модель \(model)")
            }
        }
    }
    
    
    init(model: String, yearsOfIssue: UInt16, bodyVolume: UInt16, trunkVolume: UInt16, windowsAreOpen: WindowsConditions, loadTheCargoIntoTheTrunk: OperationsLoadTrunk, loadTheCargoIntoTheBack: OperationsLoadBack) {
        
        self.model = model
        self.yearsOfIssue = yearsOfIssue
        self.bodyVolume = bodyVolume
        self.trunkVolume = trunkVolume
        self.windowsAreOpen = windowsAreOpen
        self.loadTheCargoIntoTheTrunk = loadTheCargoIntoTheTrunk
        self.loadTheCargoIntoTheBack = loadTheCargoIntoTheBack
        
    }
    
    func getEngineStarted() -> EngineConditions{
        // Подскажите на сколько правильно не писать "return" по мне так читаемость хуже становится
        engineStarted
    }
    
    func getModel() -> String{
        return model
    }
    
    func getYearsOfIssue() -> UInt16{
        return yearsOfIssue
    }
    
    func getBodyVolume() -> UInt16{
        return bodyVolume
    }
    
    func getTrunkVolume() -> UInt16{
        return trunkVolume
    }
    
    func getWindowsAreOpen() -> WindowsConditions{
        return windowsAreOpen
    }
    
    func getLoadTheCargoIntoTheTrunk() -> OperationsLoadTrunk{
        return loadTheCargoIntoTheTrunk
    }
    
    func getLoadTheCargoIntoTheBack() -> OperationsLoadBack{
        return loadTheCargoIntoTheBack
    }
    
    mutating func setEngineStarted(_ engineStarted: EngineConditions){
        self.engineStarted = engineStarted
        print(getEngineStarted().rawValue)
    }
    
    mutating func setWindowsAreOpen(_ windowsAreOpen: WindowsConditions){
        self.windowsAreOpen = windowsAreOpen
    }
    
    mutating func setLoadTheCargoIntoTheTrunk(_ loadTheCargoIntoTheTrunk: OperationsLoadTrunk){
        self.loadTheCargoIntoTheTrunk = loadTheCargoIntoTheTrunk
    }
    
    mutating func setLoadTheCargoIntoTheBack(_ loadTheCargoIntoTheBack: OperationsLoadBack){
        self.loadTheCargoIntoTheBack = loadTheCargoIntoTheBack
    }
    
}

// Создание объектов

var sportCar = Car(model: "Sport car", yearsOfIssue: 2019, bodyVolume: 244, trunkVolume: 78, windowsAreOpen: WindowsConditions.close, loadTheCargoIntoTheTrunk: OperationsLoadTrunk.restingState, loadTheCargoIntoTheBack: OperationsLoadBack.restingState)

let indent = "===================================================="

sportCar.setLoadTheCargoIntoTheTrunk(.loadIntoTheTrunk)
print(indent)
sportCar.setLoadTheCargoIntoTheTrunk(.unloadIntoTheTrunk)
print(indent)

sportCar.setLoadTheCargoIntoTheBack(OperationsLoadBack.loadIntoTheBack)
print(indent)
sportCar.setLoadTheCargoIntoTheBack(OperationsLoadBack.unloadIntoTheBack)
print(indent)

var trunkCar = Car(model: "Trunk car", yearsOfIssue: 2001, bodyVolume: 600, trunkVolume: 305, windowsAreOpen: WindowsConditions.open, loadTheCargoIntoTheTrunk: OperationsLoadTrunk.restingState, loadTheCargoIntoTheBack: OperationsLoadBack.restingState)

trunkCar.setEngineStarted(.switchedOn)
print(indent)
//trunkCar.setEngineStarted(.SwitchedOff)
//print(indent)

trunkCar.setWindowsAreOpen(.open)
print(indent)

// Выведем состояния по каждой машине

func conditionsOfCar(_ car: Car) {
    let message =
        "Модель машины \"\(car.getModel())\" \n" +
        "Год выпуска \"\(car.getYearsOfIssue())\" \n" +
        "Объём кузова \"\(car.getBodyVolume())\" \n" +
        "Объём багажника \"\(car.getTrunkVolume())\" \n" +
        "Состояние двигателя \"\(car.getEngineStarted().rawValue)\" \n" +
        "Состояние окон \"\(car.getWindowsAreOpen().rawValue)\" \n" +
        "Состояние загрузки кузова \"\(car.getLoadTheCargoIntoTheBack().rawValue)\" \n" +
        "Состояние выгрузки багажника \"\(car.getLoadTheCargoIntoTheTrunk().rawValue)\""
    print(message)
}

let arr: Array<Car> = [sportCar, trunkCar]

for el in arr {
    conditionsOfCar(el)
    print(indent)
}//
