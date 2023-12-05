# Core Data Exploration with Small Examples

#### Welcome to the world of Core Data exploration! This README.md serves as a guide to experiment with various Core Data functionalities through small examples. Let's dive into the intricacies of Core Data, one example at a time. Happy coding! 🚀

## HitList
#### Key Points learned by implementing **HitList** app

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
