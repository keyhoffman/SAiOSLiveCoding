//
//  CustomOperators.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Precedence Groups

// MARK: Applicative

precedencegroup ApplicativePrecedence { associativity: left higherThan: LogicalConjunctionPrecedence lowerThan: NilCoalescingPrecedence }

// MARK: Monadic

precedencegroup MonadicPrecedenceLeft  { associativity: left higherThan: AssignmentPrecedence lowerThan: LogicalDisjunctionPrecedence }
precedencegroup MonadicPrecedenceRight { associativity: left higherThan: AssignmentPrecedence lowerThan: LogicalDisjunctionPrecedence }

// MARK: Pipe

precedencegroup PipePrecedenceLeft  { associativity: left  higherThan: ApplicativePrecedence        lowerThan: NilCoalescingPrecedence }
precedencegroup PipePrecedenceRight { associativity: right higherThan: LogicalDisjunctionPrecedence lowerThan: NilCoalescingPrecedence }

// MARK: Composition

precedencegroup CompositionPrecedenceRight { associativity: right higherThan: BitwiseShiftPrecedence }
precedencegroup CompositionPrecedenceLeft  { associativity: right higherThan: BitwiseShiftPrecedence }

// MARK: - Declarations

infix operator <*> : ApplicativePrecedence
infix operator <^> : ApplicativePrecedence

infix operator >>- : MonadicPrecedenceLeft
infix operator -<< : MonadicPrecedenceRight
infix operator >-> : MonadicPrecedenceRight
infix operator <-< : MonadicPrecedenceLeft

infix operator |>  : PipePrecedenceLeft
infix operator <|  : PipePrecedenceLeft

infix operator |>> : CompositionPrecedenceLeft
infix operator <<| : CompositionPrecedenceRight

// MARK: - Implementations

// MARK: Functors

public func <^> <A, B>(_ f:           (A) -> B, _ functor: [A]) ->       [B]       { return functor.map(f) }
public func <^> <A, B>(_ f:           (A) -> B, _ functor: A?) ->        B?        { return functor.map(f) }
public func <^> <A, B>(_ f: @escaping (A) -> B, _ functor: Result<A>) -> Result<B> { return functor.map(f) }

@discardableResult public func <^> <A, B>(_ functor: [A],       _ f:           (A) -> B) -> [B]       { return functor.map(f) }
@discardableResult public func <^> <A, B>(_ functor: A?,        _ f:           (A) -> B) -> B?        { return functor.map(f) }
@discardableResult public func <^> <A, B>(_ functor: Result<A>, _ f: @escaping (A) -> B) -> Result<B> { return functor.map(f) }

// MARK: Applicatives

public func <*> <A, B>(_ f: [(A) -> B],        _ applicative: [A]) ->       [B]       { return applicative.apply(f) } // FIXME: NAME THE LABELS CORRECTLY!!!
public func <*> <A, B>(_ f:  ((A) -> B)?,      _ applicative: A?) ->        B?        { return applicative.apply(f) } // FIXME: NAME THE LABELS CORRECTLY!!!
public func <*> <A, B>(_ f:  Result<(A) -> B>, _ applicative: Result<A>) -> Result<B> { return applicative.apply(f) } // FIXME: NAME THE LABELS CORRECTLY!!!

// MARK: Monads

public func >>- <A, B>(_ monad: [A],       _ f: (A) -> [B]) ->       [B]       { return monad.flatMap(f) }
public func >>- <A, B>(_ monad: A?,        _ f: (A) -> B?) ->        B?        { return monad.flatMap(f) }
public func >>- <A, B>(_ monad: Result<A>, _ f: (A) -> Result<B>) -> Result<B> { return monad.flatMap(f) }

public func -<< <A, B>(_ f: (A) -> [B],       _ monad: [A]) ->       [B]       { return monad.flatMap(f) }
public func -<< <A, B>(_ f: (A) -> B?,        _ monad: A?) ->        B?        { return monad.flatMap(f) }
public func -<< <A, B>(_ f: (A) -> Result<B>, _ monad: Result<A>) -> Result<B> { return monad.flatMap(f) }

// MARK: Monadic Compositions

public func >-> <A, B, C>(_ f: @escaping (A) -> [B],       _ g: @escaping (B) -> [C]) ->       (A) -> [C]       { return { f($0) >>- g } }
public func >-> <A, B, C>(_ f: @escaping (A) -> B?,        _ g: @escaping (B) -> C?) ->        (A) -> C?        { return { f($0) >>- g } }
public func >-> <A, B, C>(_ f: @escaping (A) -> Result<B>, _ g: @escaping (B) -> Result<C>) -> (A) -> Result<C> { return { f($0) >>- g } }

public func <-< <A, B, C>(_ f: @escaping (B) -> [C],       _ g: @escaping (A) -> [B]) ->       (A) -> [C]       { return { g($0) >>- f } }
public func <-< <A, B, C>(_ f: @escaping (B) -> C?,        _ g: @escaping (A) -> B?) ->        (A) -> C?        { return { g($0) >>- f } }
public func <-< <A, B, C>(_ f: @escaping (B) -> Result<C>, _ g: @escaping (A) -> Result<B>) -> (A) -> Result<C> { return { g($0) >>- f } }

// MARK: Pipes

public func <| <A, B>(_ f: (A) -> B, _ x: A) -> B { return f(x) }
public func |> <A, B>(_ x: A, _ f: (A) -> B) -> B { return f(x) }

// MARK: Compositions

public func <<| <T, U, V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> U) -> (T) -> V { return compose(f, g) }
public func |>> <T, U, V>(_ f: @escaping (T) -> U, _ g: @escaping (U) -> V) -> (T) -> V { return compose(g, f) }

public func compose<T, U, V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> U) -> (T) -> V { return { f(g($0)) } }
