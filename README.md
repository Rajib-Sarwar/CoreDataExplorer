# Core Data Exploration with Small Examples

#### Welcome to the world of Core Data exploration! This README.md serves as a guide to experiment with various Core Data functionalities through small examples. Let's dive into the intricacies of Core Data, one example at a time. Happy coding! 🚀

## HitList
#### Basic Core Data implementation

- Core Data provides on-disk persistence, 
  which means data will be accessible even after terminating app or shutting down device.
  This is different from in-memory persistence, which will only save data as long as app is in memory, either in the foreground or in the background.
- Xcode comes with a powerful Data Model editor, which can be used to create your managed object model.
- A managed object model is made up of entities, attributes and relationships
- An entity is a class definition in Core Data.
- An attribute is a piece of information attached to an entity.
- A relationship is a link between multiple entities.
- An NSManagedObject is a run-time representation of a Core Data entity. It can be read and write to its attributes using Key-Value Coding.
- It needs an NSManagedObjectContext to save() or fetch(_:) data to and from Core Data.


## BowTie
#### NSManagedObject Subclasses

- Core Data supports different attribute data types, which determines the kind of data it can store in the entities and how much space they will occupy on disk.
  Some common attribute data types are String, Date, and Double.
- The Binary Data attribute data type gives the option of storing arbitrary amounts of binary data in the data model.
- The Transformable attribute data type store any object that conforms to NSSecureCoding in your data model.
- Using an NSManagedObject subclass is a better way to work with a Core Data entity.
  It can either generate the subclass manually or let Xcode do it automatically.
- It can refine the set entities fetched by NSFetchRequest using an NSPredicate.
- It can set validation rules (e.g. maximum value and minimum value) to most attribute data types directly in the data model editor.
  The managed object context will throw an error if you try to save invalid data.

## DogWalk
#### Core Data Stack

- The **Core Data Stack** is made up of five classes:
  **NSManagedObjectModel** , **NSPersistentStore** , **NSPersistentStoreCoordinator** , **NSManagedObjectContext** and the **NSPersistentContainer** that holds everything together.
- The **managed object model** represents each object type in your app’s data model,
  the properties they can have, and the relationship between them.
- A **persistent store** can be backed by a SQLite database (the default), XML, a binary file or in- memory store.
  You can also provide your own backing store with the incremental store API.
- The **persistent store coordinator** hides the implementation details of how your persistent stores are configured
  and presents a simple interface for your managed object context
- The **managed object context** manages the lifecycles of the managed objects it creates or fetches.
  They are responsible for fetching, editing and deleting managed objects, as well as more powerful features such as validation, faulting and inverse relationship handling.


## BubbleTeaFinder
#### Intermediate Fetching

Here are the five different ways to set up a fetch request:
```
// 1
let fetchRequest1 = NSFetchRequest<Venue>()
let entity = NSEntityDescription.entity(forEntityName: "Venue" in: managedContext)
fetchRequest1.entity = entity
```
You initialize an instance of NSFetchRequest as generic type: NSFetchRequest<Venue>. 
At a minimum, you must specify a NSEntityDescription for the fetch request. 
In this case, the entity is Venue . 
You initialize an instance of NSEntityDescription and use it to set the fetch request’s entity property.
```
// 2
let fetchRequest2 = NSFetchRequest<Venue>(entityName: "Venue")
```
Here you use NSFetchRequest ’s convenience initializer. 
It initializes a new fetch request and sets its entity property in one step. 
You simply need to provide a string for the entity name rather than a full-fledged NSEntityDescription .
```
// 3
let fetchRequest3: NSFetchRequest<Venue> = Venue.fetchRequest()
```
Just as the second example was a contraction of the first, the third is a contraction of the second. 
When you generate an NSManagedObject subclass, this step also generates a class method that returns an NSFetchRequest already set up to fetch corresponding entity types. 
This is where Venue.fetchRequest() comes from. This code lives in **Venue+CoreDataProperties.swift***

```
// 4
let fetchRequest4 = managedObjectModel.fetchRequestTemplate(forName: "venueFR")
```
In the fourth example, you retrieve your fetch request from your NSManagedObjectModel . You can configure and store commonly used fetch requests in Xcode’s data model editor.
```
// 5
let fetchRequest5 = managedObjectModel.fetchRequestFromTemplate(withName: "venueFR" substitutionVariables: ["NAME": "ViVi Bubble Tea"])
```
The last case is similar to the fourth. Retrieve a fetch request from your managed object model, but this time, you pass in some extra variables. 
These “substitution” variables are used in a predicate to refine your fetched results.


  
