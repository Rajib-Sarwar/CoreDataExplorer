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
