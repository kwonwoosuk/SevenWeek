//
//  PersonViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/5/25.
//

import Foundation

class PersonViewModel: BaseViewModel { 
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let loadButtonTapped = Observable(())
        let resetBUttonTapped = Observable(())
    }
    
    struct Output {
        var people: Observable<[Person]> = Observable([])
    }
    
    // 테이블뷰에 보여줄 데이터
    init() {
        input = Input()
        output = Output()
        
        input.loadButtonTapped.bind { _ in
            self.load()
        }
        
        input.resetBUttonTapped.bind { _ in
            self.reset()
        }
        
        transform()
    }
    
    func transform() {
        input.loadButtonTapped.bind { _ in
            let newPeople =  self.generateRandomPeople()
            self.output.people.value.append(contentsOf: newPeople)
        }
        
        
    }
    
    
    let navigationTitle = "Person List"
    let resetTitle = "리셋버튼"
    let loadTitle = "로드버튼"
    
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func load() {
        output.people.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        output.people.value.removeAll()
        
    }
    
}


