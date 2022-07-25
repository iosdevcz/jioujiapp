//
//  SystemEnvironment.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 23.07.2022.
//

import ComposableArchitecture

@dynamicMemberLookup
struct SystemEnvironment<Environment> {
    var environment: Environment
    
    subscript<Dependency>(
        dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
    ) -> Dependency {
        get { self.environment[keyPath: keyPath] }
        set { self.environment[keyPath: keyPath] = newValue }
    }
    
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    
    static func sandbox(environment: Environment) -> Self {
        Self(environment: environment, mainQueue: { .main })
    }

    static func preview(environment: Environment) -> Self {
        Self(environment: environment, mainQueue: { .main })
    }
}
