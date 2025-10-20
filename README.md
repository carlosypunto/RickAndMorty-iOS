# Rick and Morty (iOS)

## Description
A small, production-like iOS app that lists Rick & Morty characters with infinite scrolling, clean layering and strong separation of concerns. It showcases modern Swift 6 concurrency, SwiftUI with `Observation`, a lightweight actor-based cache, explicit error mapping, and a well-factored test suite using Swift’s `Testing`.

**Requirements:** Xcode 26+, iOS 17.1+, Swift 6.2

## Used technologies
- **Swift 6.2** (`async/await`, `Sendable`, actors)
  The App Target is setted with  *Approachable Concurrency = Yes* and *Default Actor Isolation = MainActor*
- **SwiftUI + Observation** (`@Observable`, state machine in the ViewModel)
- **Swift Testing** (`@Test`) for unit tests across modules
- **Swift Package Manager** (modularized: Domain, Data, Core/NetworkClient)
- **URLSession** behind a minimal **NetworkClient** abstraction
- **Localization** with `Localizable.xcstrings`
- **Accessibility** basics on list cells (labels)

## Architecture
Layered, dependency-inverted design:

```
App (SwiftUI)
  └─ Presentation
      └─ Use Cases (Domain)
          └─ Repository Protocols (Domain)
              └─ Repository Impl + Cache (Data)
                  └─ Services (Data)
                      └─ NetworkClient (Core)
```

**Quality & Testing.** The main focus of this take-home was testing: we achieved ~90–95% unit test coverage across the core business logic (Domain/Data/ViewModels), intentionally excluding SwiftUI views. Tests cover the pagination state machine, error mapping, DTO ↔ domain mapping, networking failures, cache behavior, and concurrency aspects (cancellation and re-entrancy).

**Modules & key types**

- **App** (`app/RickAndMorty`)
  - `ListScreen` (SwiftUI) + `ListScreenViewModel` (`@Observable`) with a simple `ViewState`
  - UI mappers (`Domain → UI`), error → screen mapping, DI container (`DefaultContainer`)
- **Domain** (`packages/RickAndMorty/RickAndMortyDomain`)
  - Entities: `Character`, `Episode`, `Location`, paginated `Page<T>`
  - Use case: `GetCharactersPageUseCase`
  - Repository contracts: `RickAndMortyRepository` (+ characters/episodes/locations)
- **Data** (`packages/RickAndMorty/RickAndMortyData`)
  - `RickAndMortyRepositoryImpl` (public), small in-memory **`RepositoryCache`** via `MemoryCache` (actor)
  - DTOs + mappers + error mappers; services per feature (characters/episodes/locations)
- **Core/NetworkClient** (`packages/Core/NetworkClient`)
  - `NetworkClient` protocol, `URLRequestBuilder`, `URLSession` adapter, error typing

## Notes
- **Behavior:** first page loads on appear; subsequent pages prefetch as you reach the end of the list. Errors surface with a retry action when possible.

- **Caching:** best-effort, process-local `MemoryCache` (actor). Easy to swap for a different `RepositoryCache`.

- **Testing:** unit tests live in each package + app tests for the ViewModel. Run tests in Xcode for App and/or package with iOS >= 17.1 as target

- **How to run**
  
  - Open the project: `app/RickAndMorty/RickAndMorty.xcodeproj` → run on iOS 17.1+.
  
- **Extensibility ideas:** plug a public factory for the repository to hide the concrete type, add request cancelation on disappear, TTL/size policy to the cache, and extra UI tests, maybe more screens and navigation and some kind of design system

  
